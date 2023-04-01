{ inputs, lib, config, pkgs, ... }: {
  
  # import program specific modules
  imports = [
  ./programs/git.nix
  ./shell/zsh.nix
  ./shell/cli.nix
  ./shell/starship.nix
  ./customization/fonts.nix
  ];

    nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
# neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "nom";
    homeDirectory = "/home/nom";

    # s/o JavaCafe01
     activation = {
      installAwesomeConfig = ''
        if [ ! -d "${config.home.homeDirectory}/.config/awesome" ]; then
          ln -s "/etc/nixos/home/desktop/awesome" "${config.home.homeDirectory}/.config/awesome" 
        fi
      '';
    };

    file = {
      ".xinitrc".source = ./xinitrc;
    };

    sessionVariables = {
      EDITOR = "hx";
      SHELL = "${pkgs.zsh}/bin/zsh";
      BROWSER = "firefox";
    };

    packages = with pkgs; [
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      _1password-gui
      bat
      btop
      cargo
      clang
      dig
      discord
      exa
      ffmpeg
      firefox
      gimp
      go
      helix
      httpie
      kitty
      ladybird
      lua
      maestral
      mpv
      neovim
      nerdfonts
      nodejs
      ouch
      python3
      qemu
      ripgrep
      rust-analyzer
      rustc
      spotify
      steam
      tailscale
      termius
      tetrio-desktop
      transmission
      unzip
      zathura
      zoom-us
    ];
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
