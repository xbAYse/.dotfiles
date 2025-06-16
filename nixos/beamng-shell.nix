{ pkgs ? import <nixpkgs> {} }: 
let
  libraryPath = pkgs.lib.makeLibraryPath [
    pkgs.fontconfig
    pkgs.freetype
    pkgs.glib
    pkgs.nss
    pkgs.nspr
    pkgs.dbus
    pkgs.atk
    pkgs.cups
    pkgs.libdrm
    pkgs.xorg.libX11
    pkgs.xorg.libXcomposite
    pkgs.xorg.libXdamage
    pkgs.xorg.libXext
    pkgs.xorg.libXfixes
    pkgs.xorg.libXrandr
    pkgs.libgbm
    pkgs.xorg.libxcb
    pkgs.libxkbcommon
    pkgs.pango
    pkgs.cairo
    pkgs.alsa-lib

    pkgs.vulkan-loader
    pkgs.libglvnd
  ]; 

in
pkgs.mkShell {
  shellHook = ''
    export LD_LIBRARY_PATH="${libraryPath}:/run/opengl-driver/lib:$LD_LIBRARY_PATH"
    export VK_DEVICE_SELECT=0
  '';
}
