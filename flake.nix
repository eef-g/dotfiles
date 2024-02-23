# {
#   description = "Nixos config flake";

#   inputs = {
#     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

#     home-manager = {
#     	url = "github:nix-community/home-manager";
#     	inputs.nixpkgs.follows = "nixpkgs";
#     };
#   };
#   outputs = { self, nixpkgs, ... }@inputs:
#     let 
#       system = "x86_64-linux";
#       pkgs = nixpkgs.legacyPackages.${system};
#       lib = nixpkgs.lib;

#       # Bulk module imports
#       modules = {
#         cli-tools = builtins.mapAttrs (name: path: "${self}/modules/home-manager/cli-tools/${name}") (builtins.readDir "${self}/modules/home-manager/cli-tools");
#         terminals = builtins.mapAttrs (name: path: "${self}/modules/home-manager/terminals/${name}") (builtins.readDir "${self}/modules/home-manager/terminals");
#         software = builtins.mapAttrs (name: path: "${self}/modules/home-manager/software/${name}") (builtins.readDir "${self}/modules/home-manager/software");
# 	dev-tools = builtins.mapAttrs (name: path: "${self}/modules/home-manager/dev-tools/${name}") (builtins.readDir "${self}/modules/home-manager/dev-tools");
#       };
#     in
#     {
#       nixosConfigurations = {
#         default = nixpkgs.lib.nixosSystem {
#           specialArgs = {inherit inputs;};
#           modules = [
#             ./hosts/default/configuration.nix
#           ];
#         };

#         laptop = nixpkgs.lib.nixosSystem {
#           specialArgs = {inherit inputs;};
#           modules = [
#             ./hosts/laptop/configuration.nix
#             ./hosts/laptop/hardware-configuration.nix
#           ] 
#           ++ builtins.attrValues modules.cli-tools
#           ++ builtins.attrValues modules.terminals
#           ++ builtins.attrValues modules.software;
#         };

# 	wsl = nixpkgs.lib.nixosSystem {
# 	  specialArgs = {inherit inputs;};
# 	  modules = [
# 	    ./hosts/wsl/configuration.nix
# 	    ./hosts/wsl/hardware-configuration.nix
# 	  ]
# 	  ++ builtins.attrValues modules.cli-tools
# 	  ++ builtins.attrValues modules.dev-tools;
# 	};
#       };
#     };
# }

{
  description = "NixOS configuration & Home Manager flake for eef";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  hyprland.url = "github:hyprwm/Hyprland";
  hyprland-plugins = {
    url = "github:hyprwm/hyprland-plugins";
    inputs.nixpkgs.follows = "hyprland";
  };

  ags.url = "github:Aylur/args";

  lf-icons = {
    url = "github:gokcechan/lf";
    flake = false;
  };

  firefox-gnome-theme = {
    url = "github:rafaelmardojai/firefox-gnome-theme";
    flake = false;
  };

  outputs = { home-manager, nixpkgs, ...}@inputs: let
    username = "eef";
    hostname = "nixos";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    asztal = pkgs.callPackage ./ags {inherit inputs; };
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs username hostname system;
        greeter = asztal.greeter;
      };
      modules = [
        ./nixos/configuration.nix
      ];
    };

    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs username azstal; };
      modules = [ ./home-manager/home.nix];
    };

    packages.${system} = {
      config = asztal.desktop.config;
      default = asztal.desktop.script;
      greeter = asztal.greeter.script;
    }
  }
}