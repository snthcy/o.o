# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./shell/zsh.nix
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

  # TODO: Set your username
  home = {
    username = "nom";
    homeDirectory = "/home/nom";
  };

  home.sessionVariables = {
      EDITOR = "nvim";
      SHELL = "${pkgs.zsh}/bin/zsh";
      BROWSER = "${pkgs.vivaldi}/bin/vivaldi";
}

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    go
    cargo
    rustc
    qemu
    python3
    lua
    neovim
    vivaldi
    clang
    rust-analyzer
    ripgrep
    mpv
    zoom-us
    gimp
    exa
    dig
    _1password-gui
    spotify
    discord
    steam
    kitty
    transmission
    maestral
    httpie
    tailscale
    tetrio-desktop
    termius
    nodejs
    ouch
    ffmpeg
];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}