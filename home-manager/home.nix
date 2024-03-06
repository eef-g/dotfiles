{inputs, pkgs, username, ... }:
let
  homeDirectory = "/home/${username}";
in
{
  #############
  #  Imports  #
  #############


  # Imports w/ no configuration
  imports = [
    ./packages.nix
    ./ags.nix
  ];
  # Imports w/ custom configuration
  # THIS IS ONLY FOR THE INITIAL PACKAGES, DO NOT ADD MORE HERE AND EXPECT THEM TO WORK :)
  programs.zsh = import ./zsh.nix { 
    inherit pkgs;
    use-custom = false;
    enable-starship = true;
  };
  programs.hyprland = import ./hyprland.nix {
    inherit pkgs;
    use-custom = false;
  };


  #############
  #  Configs  #
  #############
  # System configuration
  news.display = "show";
  targets.genericLinux.enable = true;
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };
  home = {
    inherit username homeDirectory;
    sessionVariables = {
      QT_XCB_GL_INTEGRATION = "none"; # kde-connect
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
      BAT_THEME = "base16";
      GOPATH = "${homeDirectory}/.local/share/go";
      GOMODCACHE="${homeDirectory}/.cache/go/pkg/mod";
    };
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };
  gtk.gtk3.bookmarks = [
    "file://${homeDirectory}/Documents"
    "file://${homeDirectory}/Music"
    "file://${homeDirectory}/Pictures"
    "file://${homeDirectory}/Videos"
    "file://${homeDirectory}/Downloads"
    "file://${homeDirectory}/Desktop"
    "file://${homeDirectory}/.config Config"
    "file://${homeDirectory}/.local/share Local"
  ];
  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
  programs.home-manager.enable = true;


  #############
  #  Version  #
  #############
  home.stateVersion = "21.11";
}
