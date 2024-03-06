{
  description = "Eef's NixOS configuration";

  inputs = {
    # Get the latest NixOS unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Get the latest home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Get the latest Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.nixpkgs.follows = "hyprland";
    };
    # Get the latest AGS & Dependencies (These are used for wigets in Hyprland)
    matugen.url = "github:InioX/matugen";
    ags.url = "github:Aylur/ags";
    stm.url = "github:Aylur/stm";
  };

  outputs = { home-manager, nixpkgs, ...}@inputs: let
    username = "<TEMP_USERNAME>";
    hostname = "<TEMP_HOSTNAME>";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    widgets = pkgs.callPackage ./ags { inherit inputs; };
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs username hostname system widgets;
      };
      modules = [
        ./nixos/configuration.nix
      ];
    };

    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs username widgets; };
      modules = [ ./home-manager/home.nix];
    };

    packages.${system}.default = widgets;
  };
}
