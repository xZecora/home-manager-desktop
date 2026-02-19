{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    melonds       # DS
    ryubing       # Switch
    azahar        # 3DS
    mgba          # Gameboy
    dolphin-emu   # Gamecube/Wii
    scummvm       # Old Games
    libretro.scummvm
  ];
}
