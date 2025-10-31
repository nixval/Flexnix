/*
 * File: users/nixval.nix
 *
 * Description:
 * This file defines a specific user's preferences and module toggles.
 * All 'enable...' flags are defined here, making the configuration
 * portable and modular.
 */
{
  # User-specific details
  # username = "nixval";
  allowUnfree = true;  
  # --- Module Toggles ---
  # These flags determine which modules are loaded from
  # 'home/modules/' for this user.
  enableZsh = true;
  enableNvf = true;
  enableYazi = true;
  enableTmux = true;
  enableVscode = true;
  enableStylix = false;
  enableSecrets = true;
  enableKitty = true;
  enableCachix = true;
  enableDevelopment = true;
  enableFlatpak = true;    
  enableCommonApps = true;
  enableAndroid = false; 
}
