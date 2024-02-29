{ pkgs, ... }: {

  programs.zsh = {
    enable = true;
    shellAliases = {
      update = "$HOME/nix/rebuild.sh";
      build-nix = "$HOME/nix/rebuild.sh -m nix";
      build-home = "$HOME/nix/rebuild.sh -m home";
    };

    # Plugin Management 
      plugins = [ 
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ../p10k-config;
          file = "p10k.zsh";
        }
      ];
  };
}
