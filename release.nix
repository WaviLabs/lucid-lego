let
  pkgs = import <nixpkgs> { };

in
  pkgs.haskellPackages.callPackage ./lucid-lego.nix { }

