{ pkgs, ... }:
{
  home.packages = with pkgs; with nodePackages_latest; with gnome; [
    sway

    # gui
    libreoffice
    spotify
    caprine-bin
    d-spy
    easyeffects
    github-desktop
    gimp
    transmission_4-gtk
    discord
    vesktop
    bottles
    icon-library
    dconf-editor
    vscode
    brave
    protonvpn-gui
    starship

    # tools
    bat
    eza
    fd
    ripgrep
    fzf
    socat
    jq
    acpi
    inotify-tools
    ffmpeg
    libnotify
    killall
    zip
    unzip
    glib
    neofetch
    onefetch
    ranger
    gnupg
    nerdfonts
    cmake
    gnumake

    # hyprland
    wl-gammactl
    wl-clipboard
    wf-recorder
    hyprpicker
    wayshot
    swappy
    slurp
    imagemagick
    pavucontrol
    brightnessctl
    swww
    hyprpaper
    rofi

    # fun
    glow
    slides
    skate
    yabridge
    yabridgectl
    wine-staging
    distrobox
    cowsay

    # langs
    nodejs
    gjs
    bun
    cargo
    go
    gcc
    typescript
    eslint
  ];
}
