{ config, pkgs, ... }:

{
  imports = [
    ./modules/neovim/neovim.nix
    #./modules/firefox.nix
    ./modules/gtk.nix
    #./modules/kdeconnect.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vitrial";
  home.homeDirectory = "/home/vitrial";

  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  services.dunst = {
    enable = true;
  };

  programs.kakoune = {
    #enable = true;
    #plugins = with pkgs.kakounePlugins; [ kak-fzf powerline-kak  kaktree];
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    libation
    nitrogen
    dzen2
    bat
    xclip
    zathura
    rofi
    ripgrep
    #vesktop
    #discord
    #vencord
    #spotify
    appimage-run
    obsidian
    pcmanfm
    neofetch
    lazygit
    pstree
    localsend
    spotifyd
    r2modman
    #atlauncher
    #prismlauncher-unwrapped
    gdlauncher-carbon
    jdk
    jdk21
    lutris
    #floorp
    firefox
    protontricks
    htop
    dolphin-emu
    flameshot
    onlyoffice-desktopeditors
    mumble
    fluffychat
    iamb
    revolt-desktop
    #(retroarch.override {
    #  cores = with libretro; [
    #    dolphin
    #  ];
    #})
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  services.gnome-keyring.enable = true;

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
  home.sessionVariables = {
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "vitrial";
      email = "vitrial@vitrial.xyz";
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
}
