let
  pkgs = import (fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-18.03.tar.gz) {};
in
  pkgs.stdenv.mkDerivation {
    name = "markdown-builder";
    src = ./.;
    buildInputs = with pkgs; [
      pandoc
      chromium
    ];
    installPhase = ''
      mkdir -p $out/
      mv *.html *.pdf $out/
    '';
  }
