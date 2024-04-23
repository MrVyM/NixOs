# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ./package.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
  	enable = true;
	desktopManager = {
		xterm.enable = false;
	};
	displayManager = {
		defaultSession = "none+i3";
	};

	windowManager.i3 = {
		enable = true;
		extraPackages = with pkgs; [
			dmenu 
			i3status
			i3lock
		];
	};
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vym = {
    isNormalUser = true;
    home = "/home/vym";
    description = "El senor vym";
    extraGroups = [ "networkmanager" "wheel" "audio" "power"];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
  	enable = true;
	enableCompletion = true;
	autosuggestions.enable = true;
	syntaxHighlighting.enable = true;
  };

  programs.neovim = {
  	enable = true;
	defaultEditor = true;
  };

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  system.stateVersion = "23.11"; # Did you read the comment?

}
