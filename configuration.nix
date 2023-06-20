{config, pkgs, lib, ... }:
{

  nixpkgs.config.allowUnfree = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  imports =
        [ 
        ./hardware-configuration.nix
        ];

	
  	boot.loader = {
        	systemd-boot.enable = true;
        	efi.canTouchEfiVariables = true;
		timeout = 0;
	};

  boot.initrd.systemd.enable = true;
  boot.kernelParams = ["amd_iommu=on" "iommu=pt" "rw"];


  networking.hostName = "maelstorm";
  networking.networkmanager.enable = true;

  virtualisation.libvirtd.enable = true; 	

  
  services.dbus.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.defaultSession = "none+Hyprland";
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "vael";
  sevices.pipewire.enable = true;
  sevices.pipewire.alsa.enable = true;
  sevices.pipewire.alsa.support32Bit = true;
  sevices.pipewire.pulse.enable = true;
  sevices.pipewire.jack.enable = true;

  security.pam.services.gtklock = {};

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "us";

  users = {
  	defaultUserShell = pkgs.zsh;
	groups = {
		vael = {};
	};
        users.vael = {
  		isNormalUser = true;
		initialPassword = "changeme";
  		extraGroups = [ "wheel" "libvirt" "kvm" "video" "autologin" "vael"];
  	};

	environment.systemPackages = with pkgs; [
        	git
		starship
		dunst
		fontconfig
		gimp
		lutris
		pavucontrol
		qemu
		steam
		libverto
		hyprland-protocols
		hyprland-share-picker
		xdg-desktop-portal-hyprland
		hyprpaper
        	btop
        	neovim
        	pulseaudio #Needed for volume keys even with pipewire
        	python3
        	unzip
        	virt-manager
        	wget
        	wl-clipboard
        	zip
		hyprland
		freetube
		bitwarden
		fuzzel
		waybar
		webcord
		brave
		firefox
		imv
		wezterm
		mpv
  ];

  programs.steam = {
	  enable = true;
	  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
	  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  	  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };

  
  fonts = {
    fonts = with pkgs; [
      noto-fonts-cjk-sans
      fira
      monocraft
      fira-code
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
      roboto
    ];

    enableDefaultFonts = true;

     fontconfig = {
      cache32Bit = true;
      defaultFonts = {
        sansSerif = ["Monocraft"];
        monospace = ["Fira Code"];
    };



  system.stateVersion = "23.05";
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-23.05";


}
