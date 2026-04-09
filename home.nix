{ config, pkgs, ... }:

{
  imports = [
    ./modules/neovim/neovim.nix
    # ./nvf/nvf.nix
    ./modules/gtk.nix
    ./modules/emulation.nix
    ./modules/zsh.nix
    ./modules/small-stuff.nix
    #./modules/firefox.nix
    #./modules/kdeconnect.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "vitrial";
    homeDirectory = "/home/vitrial";
    stateVersion = "23.11"; # Please read the comment before changing.
    sessionVariables = {
      NIX_SHELL_PRESERVE_PROMPT = 1;
    };
  };

  nixpkgs.config.allowUnfree = true;

  services.dunst = {
    enable = true;
  };

  systemd.user.services.steam = {
    Unit.Description = "Open Steam in the background at boot";
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = "${pkgs.steam} -nochatui -nofriendsui -silent %U";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  services.mpd = {
    enable = true;
    # musicDirectory = "/home/vitrial/.local/share/music";
    musicDirectory = "/server/music";
    extraConfig = ''
      audio_output {
      type "pipewire"
      name "My PipeWire Output"
    }'';
  };

  # systemd.user.services.mpd-mpris = {
  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  #   Unit = {
  #     Description = "mpd-mpris";
  #   };
  #   Service = {
  #     ExecStart = ''/home/vitrial/.nix-profile/bin/mpd-mpris'';
  #   };
  # };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    tmux
    xxHash
    jftui
    mpd-mpris
    rmpc
    spotifyd
    mpc
    any-nix-shell
    jellyfin-media-player
    jellyfin-mpv-shim
    mpv                     # Media player
    strawberry              # Audio player
    libation                # Audible ripper
    nitrogen                # Wallpaper setter
    dzen2                   # Notification software
    xclip
    zathura                 # PDF Viewer
    appimage-run            # Appimage runner
    #obsidian
    pcmanfm                 # GUI file manager
    #spotifyd                # Headless spotify daemon
    r2modman                # ROR mod manager
    (pkgs.gdlauncher-carbon.overrideAttrs (_:{ # Minecraft mod manager and java
      propagatedBuildInputs = [ jdk jdk21 ];
    }))
    floorp-bin              # Firefox fork
    librewolf
    qutebrowser
    protontricks            # Winetricks for gaming
    htop                    # System monitor
    flameshot               #screenshot tool
    onlyoffice-desktopeditors
    mumble                  # Self-hosted VoIP server
    fluffychat              # Matrix client
    revolt-desktop          # Discord alternative
    teams-for-linux         # Microsoft teams
    age
    playerctl               # Lets me play/pause audio with keybinds
    calibre
  ];

  age = {
    identityPaths = [ "/home/vitrial/.ssh/id_ed25519" ];
    secrets = {
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    #".config/mimeapps.list".text = '' [ Default Applications ] inode/directory=/nix/store/x4nnrlx7sh5bx1lgvivrwllvrgga5j3y-pcmanfm-1.3.2/share/applications/pcmanfm.desktop;'';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/vitrial/etc/profile.d/hm-session-vars.sh
  #

  programs = {
    git = {
      enable = true;
      settings.user = {
        name = "vitrial";
        email = "vitrial@vitrial.xyz";
      };
      signing.format = "openpgp";
    };
  };

  #gtk = {
  #  enable = true;
  #  theme.name = "adw-gtk3";
  #  cursorTheme.name = "Bibata-Modern-Ice";
  #  iconTheme.name = "GruvboxPlus";
  #};

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = [ "zathura.desktop" ];
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  gtk.gtk4.theme = config.gtk.theme;
}
