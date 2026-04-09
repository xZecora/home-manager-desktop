{ pkgs , ... }:
{
  home.packages = with pkgs; [
    abcde                   # CD ripper
    bat                     # Modern cat alternative
    bat-extras.core
    fastfetch               # System states fetcher
    lazygit                 # Git TUI
    astroterm               # Show the stars on any given day
    pastel                  # CLI color tool
    caligula                # Disk etcher
    qutebrowser
  ];
}
