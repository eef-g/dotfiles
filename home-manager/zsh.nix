{ pkgs, ... }: {

  programs.zsh = {
    enable = true;
    shellAliases = {
      update = "$HOME/nix/rebuild.sh";
      build-nix = "$HOME/nix/rebuild.sh -m nix";
      build-home = "$HOME/nix/rebuild.sh -m home";
    };
  };
  
  programs.starship = {
    enable = true;
    # All settings made are added to a file in ~/.config/starship.toml

    settings = {
      
    };
  };

}
