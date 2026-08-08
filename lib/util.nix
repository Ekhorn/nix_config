{ lib }:

let
  attrFromList =
    {
      features ? [ ],
      prefix ? "",
      suffix ? "",
      mkName ? (f: "${prefix}${f}${suffix}"),
      value,
    }:
    lib.genAttrs (map mkName features) (_: value);
in
{
  inherit attrFromList;
}
