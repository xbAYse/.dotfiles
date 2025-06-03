{ config, pkgs, lib, ... }:

let
  user = "bayse";  # 🔁 Replace with your actual username
in {
  systemd.user.services.hyprLogout = {
    description = "Log out from Hyprland";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.hyprland}/bin/hyprctl dispatch exit";
    };
    wantedBy = [ "default.target" ];
  };

  systemd.user.timers.hyprLogout = {
    description = "Daily logout from Hyprland at 17:17";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "17:25";
      Persistent = true;
    };
  };

  # Ensure the user systemd instance gets enabled
  users.users.${user} = {
    # Make sure the user exists here — remove this section if already defined
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Optional
  };

  # Enable lingering so user units can run when not logged in
  system.activationScripts.enableLingering = lib.stringAfter [ "users" ] ''
    loginctl enable-linger ${user}
  '';
}

