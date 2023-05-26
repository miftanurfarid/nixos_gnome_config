# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # scanner
  hardware = {
    sane = {
      enable = true;
      brscan4 = {
        enable = true;
      };
      extraBackends = with pkgs; [
        epkowa
        utsushi
      ];
    };
  };

  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Makassar";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.UTF-8";
    LC_IDENTIFICATION = "id_ID.UTF-8";
    LC_MEASUREMENT = "id_ID.UTF-8";
    LC_MONETARY = "id_ID.UTF-8";
    LC_NAME = "id_ID.UTF-8";
    LC_NUMERIC = "id_ID.UTF-8";
    LC_PAPER = "id_ID.UTF-8";
    LC_TELEPHONE = "id_ID.UTF-8";
    LC_TIME = "id_ID.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.settings.Theme.CursorTheme = "breeze_cursors";
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services = {
    printing = {
      enable = true;
      stateless = true;
      webInterface = false;
      drivers = with pkgs; [
        cnijfilter2 # nonfree
        epson-escpr
        epson-escpr2
        foomatic-db
        foomatic-db-ppds
        gutenprint
        hplip
        splix
      ];
    };
    system-config-printer = {
      enable = true;
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fafa = {
    isNormalUser = true;
    description = "Mifta Nur Farid";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [   

    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # internet
    firefox
    google-chrome
    brave
    transmission
    tor-browser-bundle-bin
    zoom-us
  
    # document
    xournalpp
    libreoffice
    lyx
    qpdfview
    libsForQt5.okular
    calibre
    mendeley
    zotero
    wpsoffice
      
    # latex
    texlive.combined.scheme-full
    texstudio

    # git
    git
    github-desktop
  
    # text editor
    vim
    neovim
    (
    vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        ms-pyright.pyright	          
        ms-python.python
        jnoortheen.nix-ide
        ];
      }
    )
  
    # graphic
    inkscape
    gimp
        
    # communication
    tdesktop

    # downloader
    axel
    wget
    
    # base
    findutils
    plocate
    mlocate
    htop
    neofetch
    rclone
    pdftk
    gparted

    # octave
    octaveFull

    # media
    vlc

    # python
    (
    python3.withPackages (
      ps: with ps; [
        ipykernel
        ipython
        ipywidgets
        jupyter
        jupyterlab
        jupyterlab-lsp
        jupyterlab-pygments
        kaggle
        keras
        matplotlib
        mkdocs
        mkdocs-jupyter
        nltk
        numpy
        opencv4
        pandas
        pydot
        python
        pytorch
        scikit-learn
        scipy
        seaborn
        spacy
        spyder
        spyder-kernels
        tensorflow
        tensorflow-metadata
        tensorflow-probability
        torch
        torchvision
        tqdm
        virtualenv
        virtualenvwrapper
        xgboost
        ]
      )
    )

    # archiver
    atool
    bzip2
    gzip
    libarchive
    lz4
    lzip
    lzo
    lzop
    p7zip
    rzip
    unrar
    unzip
    xz
    zip
    zstd

    # wine
    wineWowPackages.waylandFull

    # gnome extensions
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.clipboard-indicator
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs = {
    git = {
      enable = true;
      lfs = {
        enable = true;
      };
      config = {
        init = {
          defaultBranch = "master";
        };
        user = {
          email="miftanurfarid@gmail.com";
          name="miftanurfarid";
        };
        core = {
          filemode = false;
        };
      };
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
  
  # Enable read ntfs
  boot.supportedFilesystems = [ "ntfs" ];

  # Locate
  services.locate.enable = true;

  environment.interactiveShellInit = ''
    parse_git_branch() {
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
      }
    export PS1="\n\[\033[0;31m\][\u]\[\033[0;37m\]:\[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\n> "
    gsettings set org.gnome.shell app-picker-layout "[]"
  '';

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
    };
    settings = {
      allowed-users = ["@wheel"];
      auto-optimise-store = true;
      trusted-users = ["root" "fafa"];
    };
  };
}