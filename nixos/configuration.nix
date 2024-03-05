{ pkgs, username, hostname, ...}: {

  imports = [
    /etc/nixos/hardware-configuration.nix
#    ./nvidia.nix
    ./hyprland.nix
    # Add other nixos configuration files here
    (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")
  ];

  # NixOS Settings
  documentation.nixos.enable = false;
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  # Virtualization
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };

  # Dconf
  programs.dconf.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    # Add packages here
    home-manager
    neovim
    git
    zsh
    zsh-powerlevel10k
    wget
    kitty
    steam
    ckb-next
    # Add more packages later
  ];
  hardware.ckb-next.enable = true;
  programs.steam.enable = true;



  # Timezone
  time.timeZone = "America/Los_Angeles";

  # Services
  services = {
    xserver = {
      enable = true;
      libinput.enable = true;
      excludePackages = [ pkgs.xterm ];

      # DisplayManager & Default DM
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    printing.enable = true;
    flatpak.enable = true;
    vscode-server.enable = true;
    localtimed.enable = true;
  };


  # Logind
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=ignore
  '';

  # KDE Connect
  networking.firewall = rec {
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }]; 
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
  
  # Shell (ZSH but change to whatever shell you use)
  programs.zsh.enable = true;

  # User
  users.users.${username} = {
    isNormalUser = true;
    initialPassword = username;
    extraGroups = [
      "nixosvmtest"
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "libvirtd"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  # Network
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };


  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };

  # Bootloader
  boot = {
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "ntfs" ];
    loader = {
      timeout = 2;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # Change Theming here
  };

  system.stateVersion = "23.05";
}
