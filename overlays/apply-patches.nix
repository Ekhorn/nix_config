{ inputs }:

self: super: {
  libfprint = super.libfprint.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ../patches/goodix-60c2.patch ];
  });
}
