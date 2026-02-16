{ config, pkgs, ... }:

{
  #gtk.enable = true;

  #gtk.theme.package = pkgs.vimix-gtk-themes;
  #gtk.theme.name = "vimix-dark-doder";

  #gtk.iconTheme.package = pkgs.vimix-icon-theme;
  #gtk.iconTheme.name = "Vimix-Beryl-dark";

  #gtk.cursorTheme.name = "Breeze-light";

  #home.pointerCursor.gtk.enable = true;
  #home.pointerCursor.name = "Breeze-light";

  #home.packages = [
  #  pkgs.themechanger
  #  pkgs.dconf
  #];

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Light-Cursors";
      package = pkgs.catppuccin-cursors.mochaLight;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "Posy_Cursor_125_175";
    package = pkgs.posy-cursors;
    size = 8;
    x11.defaultCursor = "left_ptr";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Breeze-Dark";
      color-scheme = "prefer-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "gtk2";
      #package = pkgs.libsForQt5.breeze-qt5;
    };
  };

  # the above should take care of most apps, but with home manager you can go further, by doing this in addition:
  #home.file.".icons/default".source = "${pkgs.posy-cursors}/share/icons/Posy_cursor_125_175";

}
