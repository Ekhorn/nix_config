# Ref https://github.com/charmbracelet/vhs/pull/658
final: prev: {
  vhs = prev.vhs.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (final.fetchpatch {
        # Patch compared to v0.11.0
        url = "https://github.com/charmbracelet/vhs/compare/c6af91a25fed05852338a5ed58d9b099b8369a1e...runesoerensen:vhs:36882040ac5d7c6f1caedc927e4be3a652657a36.patch";
        hash = "sha256-ZO2UKAmhyux6iQAlfsn4GGPg/H2x8G7w5ZXr7rf0HsI=";
      })
    ];
  });
}
