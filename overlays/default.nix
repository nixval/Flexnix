{ inputs, ... }:

final: prev:
{

  stable = import inputs.nixpkgs-stable {
    inherit (prev) system;
    config = prev.config;
  };
}
