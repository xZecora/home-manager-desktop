{ config , ... }:

{
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        device_name = "nixos";
        device_type = "computer";
        use_mpris = true;
        dbus_type = "system";
        zeroconf_port = 2929;
        bitrate = 320;
        backend = "pulseaudio";
      };
    };
  };
}
