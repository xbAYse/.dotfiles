{ config, pkgs, inputs, ... }:

{
  imports = [      
      ./hardware-configuration.nix
      ./vm.nix
      ./drivers
    ];

  # Enable Flakes 
  nix = {
     package = pkgs.nix;
     settings.experimental-features = [ "nix-command" "flakes" ];
  }; 


  # Enable NTFS Support at Boot
  boot.supportedFilesystems = [ "ntfs" ];
 
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = ["amdgpu"];

  # Newest Linux KERNEL
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # KernalModules
  boot.kernelModules = [
    "hid-fanatec"
  ];

  # Enable Garbage Collection
  nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
  };
  
  # Use the GRUB 2 boot loader.
boot.loader = {
  timeout = 10;

  efi = {
    efiSysMountPoint = "/boot";
  };

  grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true; # Otherwise /boot/EFI/BOOT/BOOTX64.EFI isn't generated
    devices = ["nodev"];
    useOSProber = true;
    extraEntriesBeforeNixOS = false;
    extraEntries = ''
      menuentry "Reboot" {
        reboot
      }
      menuentry "Poweroff" {
        halt
      }
    '';
  };
};

  # Customize Grub
  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
    pname = "distro-grub-themes";
    version = "3.1";
    src = pkgs.fetchFromGitHub {
      owner = "AdisonCavani";
      repo = "distro-grub-themes";
      rev = "v3.1";
      hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
    };
    installPhase = "cp -r customize/nixos $out";
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable NextDNS
    services.resolved = {
    enable = true;
    extraConfig = ''
      [Resolve]
      DNS=45.90.28.0#fca42e.dns.nextdns.io
      DNS=2a07:a8c0::#fca42e.dns.nextdns.io
      DNS=45.90.30.0#fca42e.dns.nextdns.io
      DNS=2a07:a8c1::#fca42e.dns.nextdns.io
      DNSOverTLS=yes
    '';
  };
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the fish shell
  programs.fish.enable = true;

  # Enable Gnome
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  services.gnome.core-apps.enable = false;

  # Enable Niri
  programs.niri.enable = true;

  # Enable Thunar
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  services.tumbler.enable = true;
  services.gvfs.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. 
  users.users.bayse = {
    isNormalUser = true;
    description = "bayse";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  
  # Set Default Programs
  xdg.mime.enable = true;
    xdg.mime.defaultApplications = {
      "image/jpeg" = "feh";
      "image/png" = "feh";
      "image/bmp" = "feh";
      "image/tiff" = "feh";
      };
  programs.neovim.enable = true;    
  programs.neovim.defaultEditor = true;

services.udev.extraRules = let
  # Define sh and coreutils (for chmod) from pkgs
  shPath = "${pkgs.bash}/bin/sh"; # Or pkgs.coreutils/bin/sh
  chmodPath = "${pkgs.coreutils}/bin/chmod"; # Need coreutils for chmod
in
  ''
    SUBSYSTEM=="tty", KERNEL=="ttyACM*", ATTRS{idVendor}=="346e", ACTION=="add", MODE="0666", TAG+="uaccess"
    SUBSYSTEM=="misc", KERNEL=="uinput", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';

  hardware.enableRedistributableFirmware = true;
  # Install firefox.
  programs.firefox.enable = true;

  # Enable Flatpak
  services.flatpak.enable = true;

  # Enable Waydroid
  virtualisation.waydroid.enable = true;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # 
  environment.systemPackages = with pkgs; [
    steam
    protonup
    protontricks
    gamescope
    heroic
    fastfetch
    bottles
    nextdns
    mullvad-browser
    waybar
    dunst #notifications
    libnotify #notifications
    swaybg
    ghostty
    fish
    vesktop
    rofi-wayland
    xfce.thunar
    #spotify - trying to use cli  
    waypaper
    hyprpicker
    pywal
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    cowsay
    tor-browser
    hyprlock
    git
    pavucontrol
    hd-idle
    neovim
    bibata-cursors
    nwg-look
    mission-center
    oh-my-fish
    grim #screenshot
    slurp #screenshot selection
    krita
    obsidian
    vlc
    feh #image viewer
    wl-clipboard #copy utility for screenshots
    file-roller
    gnome-disk-utility
    diskscan
    thunderbird
    rclone #syncs with proton drive
    easyeffects
    parsec-bin
    slack
    sleek-grub-theme
    element-desktop
    komikku #manga reader
    android-tools
    qutebrowser
    anki
    btop
    luarocks
    vimPlugins.nvim-treesitter
    gcc
    lua
    fd
    lazygit
    fzf
    spotify-player
    playerctl
    glib
    python3Full
    github-desktop
    fortune
    xwayland-satellite
    gpu-screen-recorder
    nautilus
    eww
    gnumake
    syncthing
    boxflat
    oversteer
    linuxConsoleTools
    game-devices-udev-rules
    ];


    # Enable Default Fonts
    
    fonts.enableDefaultPackages = true;

    # Fonts Packages

    fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    jetbrains-mono
    font-awesome
    inconsolata
    wqy_microhei
    noto-fonts-cjk-sans
  ];

  # ProtonUp Session Variable
  environment.sessionVariables = {
     STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "/home/user/.steam/root/compatibilitytools.d";
  };
  # Hyprland Session Variable
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  
  nixpkgs.config.permittedInsecurePackages = [
    "electron-33.4.11"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
