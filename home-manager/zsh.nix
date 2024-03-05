{ pkgs, ... }:
  let
    # Import the custom configuration
    custom = import ../custom/zsh-custom.nix;
  in {
    options = {
      enable-starship = {
        default = true;
        description = "Enable starship prompt";
      };
      use-custom = {
        default = true;
        description = "Use custom zsh configuration";
      };

    };

    programs.zsh = {
      enable = true;

      shellAliases = if options.use-custom == true then 
      custom.shellAliases
      else 
      {
        # Default shell aliases
        update = "$HOME/nix/rebuild.sh";
        build-nix = "$HOME/nix/rebuild.sh -m nix";
        build-home = "$HOME/nix/rebuild.sh -m home";
      };
    };

    programs.starship = if options.enable-starship == true then 
    {
      enable = true;
      settings = {
        
      };
    };
  };
}
