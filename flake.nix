{
  description = "this is super fun but i also want to die because of it! i've been warned.. oh well";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    
    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    # Available through 'nixos-rebuild --flake .#hpee'
    nixosConfigurations = {
      hpee = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ ./nixos/configuration.nix ];
      };
    };

    # Available through 'home-manager --flake .#nom@hpee'
    homeConfigurations = {
      "nom@hpee" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home/hpee.nix ];
      };
    };
  };
}
