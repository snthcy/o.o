{ inputs, lib, config, pkgs, ... }: {
  
  # import program specific modules
  imports = [
  ./programs/git.nix
  ./shell/zsh.nix
  ./shell/cli.nix
  ];

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
      zip
      zoom-us
    ];
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
