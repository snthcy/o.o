# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      (final: prev:
        {
          awesome = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;
        })
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
  };

  hardware = {
    enableRedistributableFirmware = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  networking = {
    hostName = "hpee";
    networkmanager.enable = true;
  };

  # TODO: This is just an example, be sure to use whatever bootloader you prefer
  boot = {
    kernelPackages = pkgs.linuxPackages_latest; 

    loader = {
      systemd-boot.enable = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      nom = {
        initialPassword = "nixos";
        isNormalUser = true;
        # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
        extraGroups = [ 
          "wheel" 
          "networkmanager" 
          "audio" 
        ];
        shell = pkgs.zsh;
      };
    };
  };

  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      alsa-tools 
      alsa-utils
      brightnessctl
      coreutils
      curl
      wget
      home-manager
      pulseaudio
      gcc
      vim
      zsh
    ];
  };

  services = {
    openssh = {
    enable = true;
    permitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    passwordAuthentication = false;
    };

    pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;
  };

    xserver = {
      dpi = 141;
      enable = true;
      libinput.enable = true;
      displayManager.startx.enable = true;
      videoDrivers = [ "amdgpu" ];
      
      windowManager = {
        awesome = {
          enable = true;
        };
      };
    };
  };

  hardware.pulseaudio.enable = false;

  systemd.user.services = {
    pipewire.wantedBy = ["default.target"];
    pipewire-pulse = {
      path = [pkgs.pulseaudio];
      wantedBy = ["default.target"];
    };
  };
  
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}