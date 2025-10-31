/*
 * File: hosts/valiM.nix
 *
 * Description:
 * This file defines a specific machine (host).
 * It specifies the system architecture and which user configuration
 * belongs to this host.
 */
{
  # The system architecture for this host
  system = "x86_64-linux";

  # The 'user' profile to load for this host
  # This maps to 'users/nixval.nix'
  # user = "nixval";
}
