{ pkgs, ... }:
  let
    options = {
      enable-starship = {
        default = true;
        description = "Enable starship prompt";
      };
      use-custom = {
        default = false;
        description = "Use custom zsh configuration";
      };
    };
    # Import the custom configuration
    custom = import ../custom/zsh-custom.nix;
  in {
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
        # Starship config
      };
    };
  };
}
