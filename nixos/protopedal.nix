{ pkgs, ... }:
let
  name = "protopedal";
  version = "2.5";
in
pkgs.stdenv.mkDerivation {
  inherit name version;

  src = pkgs.fetchFromGitLab {
    owner = "openirseny";
    repo = name;
    tag = "release-${version}";
    hash = "sha256-3I7tpvqEE6IcWkKlRyCTF6J3+okyHwjC9ddylcU6PlE=";
  };

  buildInputs = [
    pkgs.gnumake
    pkgs.autoPatchelfHook
    pkgs.stdenv.cc.cc.lib
  ];

  buildPhase = ''
    make all
  '';

  installPhase = ''
    mkdir -p $out/bin

    install -Dm777 ./protopedal $out/bin
  '';
}
