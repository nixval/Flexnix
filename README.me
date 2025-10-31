# FlexNix: A Portable, DRY, Matrix-based Nix Configuration

Welcome to `flexnix`, a set of declarative Nix dotfiles built on Flakes, Home Manager, and `flake-parts`.

This repository is designed for **portability** and **modularity**. It manages both Home Manager configurations (for any non-NixOS machine like Linux Mint, Ubuntu, or macOS) and full NixOS system configurations from a single, clean `matrix.nix` file.

This setup is intended for intermediate-to-advanced Nix users who want a single, DRY (Don't Repeat Yourself) repo to manage all their machines and profiles.

## Features

* **Matrix Architecture**: Define all your final builds in one file (`matrix.nix`). Easily mix and match hosts, profiles, and users.
* **Dual Output**: Generates both `homeConfigurations` (for non-NixOS) and `nixosConfigurations` (for full NixOS builds) from the same matrix.
* **DRY by Design**:
    * **`hosts/`**: Defines machine-specific hardware (e.g., `system = "x86_64-linux";`).
    * **`profiles/`**: Defines *toggles* and packages (e.g., `enableDevelopment = true;`).
    * **`nixos/`**: Defines base system configurations (e.g., filesystems, bootloader).
* **Cloner-Friendly**: A cloner only needs to create their host/profile files and add **one line** to `matrix.nix`. They never need to edit the core logic in `lib/` or `flake.nix`.
* **Smart Scripts**: Includes `switch-home` and `dry-switch` aliases that automatically detect if you are on NixOS or not and run the correct command (`nixos-rebuild` vs `home-manager`).

---

## Architecture Overview

This repo uses a "Matrix" architecture. The core logic is:

**`hosts/` + `profiles/` + `nixos/` = `matrix.nix` (Your "Recipe Book")**

The "engines" in `lib/` read your `matrix.nix` file and build the final outputs.



---

## Getting Started: Initial Setup

Before you can use a profile, your machine needs a base Nix installation.

### Use Case A: On a Non-NixOS Machine (Linux Mint, Ubuntu, macOS, etc.)

This will set up **Home Manager** to manage your user environment.

1.  **Install Nix:**
    We recommend the [Determinate Systems Nix Installer](https://github.com/DeterminateSystems/nix-installer) for a modern, multi-user installation.
    ```bash
    curl --proto '=https' --tlsv1.2 -sSf -L [https://install.determinate.systems/nix](https://install.determinate.systems/nix) | sh -s -- install
    ```
    *Note: You may need to follow its instructions to add `nix` to your shell's PATH.*

2.  **Enable Flakes:**
    Nix 2.4+ is required. Enable Flakes by editing your Nix config:
    ```bash
    # Create the config file if it doesn't exist
    mkdir -p ~/.config/nix
    # Add settings
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
    ```
    *(If you installed with the Determinate installer, this may already be done.)*

3.  **Clone This Repository:**
    ```bash
    git clone [https://github.com/nixval/flexnix.git](https://github.com/nixval/flexnix.git) ~/dotfiles/flexnix
    cd ~/dotfiles/flexnix
    ```

4.  **Follow the "Cloner Workflow"** (see next section) to add your configuration.

### Use Case B: On a New NixOS Machine (Full System Install)

This will install a **full NixOS system** declaratively.

1.  **Boot from NixOS Installer:**
    Boot the minimal NixOS ISO installer.

2.  **Partition & Format:**
    Partition your drives (e.g., with `gdisk` or `parted`). Format your filesystems (e.g., `mkfs.ext4`, `mkfs.vfat`).

3.  **Mount Filesystems:**
    Mount your root partition to `/mnt`. Mount your boot partition (if separate) to `/mnt/boot`.
    ```bash
    # Example
    mount /dev/disk/by-label/NIXOS /mnt
    mount /dev/disk/by-label/BOOT /mnt/boot
    ```

4.  **Generate Base Config (For Hardware Only):**
    We *only* do this to get the `hardware-configuration.nix` file.
    ```bash
    nixos-generate-config --root /mnt
    ```

5.  **Clone This Repository:**
    Move the generated config and clone this repo in its place.
    ```bash
    # Move the generated hardware config
    mv /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/
    # Remove the placeholder config
    rm -rf /mnt/etc/nixos
    # Clone this repo
    git clone [https://github.com/nixval/flexnix.git](https://github.com/nixval/flexnix.git) /mnt/etc/nixos
    cd /mnt/etc/nixos
    ```

6.  **Move Hardware Config:**
    Move the hardware config into your new `nixos/` directory so you can import it.
    ```bash
    mv /mnt/etc/hardware-configuration.nix nixos/my-new-pc-hardware.nix
    ```

7.  **Follow the "Cloner Workflow"** (see next section) to add your configuration.
    * *Self-Correction:* You will need to create a `nixos/` file (e.g., `nixos/my-pc.nix`) that imports the `my-new-pc-hardware.nix` file you just moved.

8.  **Run the Installation:**
    Once your `matrix.nix` entry is created (e.g., `"my-user-pc-main"`), run the install command:
    ```bash
    nixos-install --flake .#my-user-pc-main
    ```

---

## The Cloner Workflow: Adding Your Configuration

This is the main workflow. You only need to do this once per new build.

**Goal:** Create a new output, e.g., `"bob-laptop-coding"`.

### Step 1: Create Your `hosts/` File

Create a new file in the `hosts/` directory (e.g., `hosts/bobs-laptop.nix`). This defines the *machine's hardware*.

```nix
/* File: hosts/bobs-laptop.nix */
{
  # Set the architecture
  system = "x86_64-linux"; 
  # (or "aarch64-linux", "x86_64-darwin", etc.)
}

Step 2: Create Your profiles/ File (or Re-use)

Create a new file in profiles/ (e.g., profiles/bobs-base.nix). This defines the toggles for your software.

You can also re-use an existing profile like profiles/coding.nix.
Nix

/* File: profiles/bobs-base.nix */
{
  allowUnfree = true;

  # Enable the modules you want
  enableZsh = true;
  enableKitty = true;
  enableDevelopment = true;
  enableFlatpak = true;
  enableCommonApps = true; # (Installs Discord, Spotify, etc.)

  # Disable modules you don't
  enableNvf = false;
  enableStylix = false;
  enableSecrets = false; # <-- IMPORTANT
  # ...etc
}

⚠️ IMPORTANT: Secret Management This repo uses agenix for secrets (like SSH keys), enabled by enableSecrets = true;. This expects a private key at /etc/nix/age.key.

As a cloner, you MUST set enableSecrets = false; in your profile, or the build will fail.

Step 3: Add Your Assembly to matrix.nix

This is the final step. Open matrix.nix and add one line to the main list.
Nix

/* File: matrix.nix */
{
  # ... (Nixval's configs)

  # --- Cloner "Bob's" Matrix ---
  "bob-laptop-coding" = {
    host = "bobs-laptop";  # -> loads hosts/bobs-laptop.nix
    profile = "coding";    # -> re-uses profiles/coding.nix
    username = "bob";
    hostname = "bobs-laptop";
    type = "home";         # -> This is a Home Manager build
  };
  
  # ...
}

Step 4: Build and Switch!

You are now ready to build. cd into the repo directory and run the "smart" script.
Bash

# To test the build without applying it:
nix run .#dry-switch -- bob-laptop-coding

# To build and activate the configuration:
nix run .#switch-home -- bob-laptop-coding

The script will detect you are on non-NixOS and run home-manager switch. If you had set type = "nixos", it would have run nixos-rebuild switch.

Customization: Adding New Modules

This architecture makes adding new software simple.

Example: Add a new module for my-app

    Create the module file: home/modules/cli/my-app.nix
    Nix

{ pkgs, ... }:
{
  # Add packages
  home.packages = [ pkgs.my-app ];
  # Add config files
  home.file.".config/my-app/config.toml".text = ''
    # settings...
  '';
}

Add the toggle to the builder: Edit lib/mkHome.nix and add a new line to the modules = [ ... ] list:
Nix

/* File: lib/mkHome.nix */
# ...
(lib.optional userConfig.enableDevelopment ../home/modules/development/default.nix)

# --- Add your new module ---
(lib.optional userConfig.enableMyApp ../home/modules/cli/my-app.nix)
];

Enable it in your profile: Edit profiles/your-profile.nix and add the new toggle:
Nix

    /* File: profiles/bobs-base.nix */
    {
      # ...
      enableMyApp = true;
    }

    Rebuild: nix run .#switch-home -- your-output-name

Your new module is now active. This same pattern works for Flatpaks, services, and more.
