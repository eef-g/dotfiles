{ config, pkgs, inputs, ... }:


{
    imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
				inputs.home-manager.nixosModules.default
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos"; 
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Los_Angeles";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };


    # Enable OpenGL
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    # Load NVidia drivers
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
    modesetting.enable = true; # This is required
    powerManagement.enable = false; # This is experimental, do not enable
    powerManagement.finegrained = false;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
    };  

    # Enable the X11 windowing system.
    services.xserver.enable = true;

	# Enable the GNOME Desktop Environment.
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;

	# Configure keymap in X11
	services.xserver = {
		layout = "us";
		xkbVariant = "";
	};

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound with pipewire.
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
		services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		# use the example session manager (no others are packaged yet so this is enabled by default,
		# no need to redefine it in your config for now)
		#media-session.enable = true;
	};

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.eef = {
		isNormalUser = true;
		description = "eef";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			brave
			vim
			alacritty
		];
	};

	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		users = {
			"eef" = import ./home.nix;
		};
	};


	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		vim
		neovim
		brave
		firefox
		alacritty 
		discord
		neofetch
		steam
		spotify
		vscode
	];

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};

	# DO NOT TOUCH PLEASE :)
	system.stateVersion = "23.11"; # Did you read the comment?

}

