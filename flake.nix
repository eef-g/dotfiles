{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
    	url = "github:nix-community/home-manager";
    	inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs:
    let 
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;

      # Bulk module imports
      modules = {
        cli-tools = builtins.mapAttrs (name: path: "${self}/modules/home-manager/cli-tools/${name}") (builtins.readDir "${self}/modules/home-manager/cli-tools");
        terminals = builtins.mapAttrs (name: path: "${self}/modules/home-manager/terminals/${name}") (builtins.readDir "${self}/modules/home-manager/terminals");
      };
    in
    {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/default/configuration.nix
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/laptop/configuration.nix
            ./hosts/laptop/hardware-configuration.nix
          ] 
          ++ builtins.attrValues modules.cli-tools
          ++ builtins.attrValues modules.terminals;
        };
      };
    };
}
