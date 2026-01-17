self: super: {
  libfprint = super.libfprint.overrideAttrs (old: {
    patches = [
      # ../patches/goodix-60c2.patch merged in https://gitlab.freedesktop.org/libfprint/libfprint/-/commit/7d9638bc4375dbfee679aeb852d7a94b3ea22783
    ];
  });
}
