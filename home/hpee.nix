{ inputs, lib, config, pkgs, ... }: {
  
  # import program specific modules
  imports = [
  ./programs/git.nix
  ./shell/zsh.nix
  ./shell/cli.nix
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

    sessionVariables = {
      EDITOR = "hx";
      SHELL = "${pkgs.zsh}/bin/zsh";
      BROWSER = "${pkgs.vivaldi}/bin/vivaldi";
    };

    packages = with pkgs; [
      _1password-gui
      bat
      btop
      cargo
      clang
      dig
      discord
      exa
      ffmpeg
      gimp
      go
      helix
      httpie
      kitty
      lua
      maestral
      mpv
      neovim
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
      vivaldi
      zoom-us
    ];
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
