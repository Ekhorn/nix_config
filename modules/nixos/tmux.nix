{ pkgs, lib, ... }:

{
  systemd.user.services.tmux = {
    description = "Start tmux at login and restore session";
    documentation = [ "man:tmux(1)" ];

    after = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "forking";
      Restart = "on-failure";
      RestartSec = "5s";

      Environment = "PATH=${
        lib.makeBinPath [
          pkgs.coreutils # provides: sleep, cut, readlink
          pkgs.gnugrep # provides: grep
          pkgs.gawk # provides: awk
          pkgs.gnused # provides: sed
          pkgs.findutils # provides: xargs
          pkgs.tmux
          pkgs.bash
        ]
      }";

      ExecStart = "${pkgs.tmux}/bin/tmux new-session -d -s boot-anchor";
      # ExecStart = "${pkgs.tmux}/bin/tmux start-server";

      ExecStartPost = pkgs.writeShellScript "tmux-restore" ''
        set -e

        # Wait until the server is ready
        until ${pkgs.tmux}/bin/tmux info >/dev/null 2>&1; do
          sleep 0.1
        done

        # Restore last session
        ${pkgs.tmux}/bin/tmux run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/restore.sh

        if [ "$(${pkgs.tmux}/bin/tmux list-sessions 2>/dev/null | wc -l)" -lt 2 ]; then
          echo "Restore not visible yet. Retrying..."
          exit 1
        fi

        # 5. Success! Kill the anchor session to keep it clean
        ${pkgs.tmux}/bin/tmux kill-session -t boot-anchor
        echo "Restore verified."

        # if ! ${pkgs.tmux}/bin/tmux list-sessions 2>/dev/null | grep -q "."; then
        #   echo "Restore failed or no sessions found. Retrying in 5s..."
        #   exit 1
        # fi

        # echo "Restore successful!"
        # exit 0
      '';

      ExecStop = "${pkgs.tmux}/bin/tmux kill-server";
      # KillMode = "mixed";
    };

    wantedBy = [ "default.target" ];
  };
}
