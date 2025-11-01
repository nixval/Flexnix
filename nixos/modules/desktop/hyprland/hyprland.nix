/*
 * File: nixos/modules/desktop/hyprland/hyprland.nix
 *
 * Description:
 * Manages NixOS system services for Hyprland.
 * This is *only* loaded if 'type = "nixos"'.
 */
{ pkgs, ... }:

{
  # 1. Install Hyprland and core dependencies to the system
  # We install hyprland here, not in the HM module.
  environment.systemPackages = with pkgs; [
    hyprland
    # Add xdg-desktop-portal-hyprland for screen sharing, etc.
    xdg-desktop-portal-hyprland
  ];

  # 2. Enable the Hyprland program
  # This sets up wrapper scripts and necessary environment vars.
  programs.hyprland.enable = true;
  
  # 3. Enable core Wayland/graphics support
  # This is crucial for Hyprland to run.
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    # If you have NVIDIA, you'd add modesetting here
    # nvidia.modesetting.enable = true;
  };

  # 4. Enable SDDM as the Display Manager (Login Screen)
  services.xserver.displayManager.sddm = {
    enable = true;
    # Use the Wayland session for SDDM itself
    wayland.enable = true;
  };

  # 5. Enable other necessary system services
  services.dbus.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
