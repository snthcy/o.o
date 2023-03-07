<div align="center">

# o.o - my personal dotfiles

[about](#about) • [setup](#setup) • [stack](#stack) • [resources](#resources)

</div>

## about

o.o is a collection of my personal system configurations, also known as "dotfiles". Currently, this is managed through a package management tool/operating system called [Nix](https://nixos.org).

> **NOTE:** - This is my setup. I cannot guarentee that it'll work for you. It's barely working for me

## setup

This guide is made with the intentions of you already having an install of NixOS. I will make a better guide later on.

Enter into an environment with Git and home-manager:
```
nix-shell -p git home-manager
```

Clone the Git repository to a safe place and cd to it:
```
git clone https://github.com/snthcy/o.o.git
cd o.o/
```

Install the NixOS system configuration with flakes:
```
nixos-install --flake '.#hpee'
```

Logout and reboot your system, then renavigate to the Git repository and setup the home-manager configuration:
```
home-manager switch --flake '.#nom@hpee'
```

## stack
tbd