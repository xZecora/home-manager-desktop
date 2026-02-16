{ config, pkgs, ... }:

{
  nixpkgs.overlays =
  let
    # Change this to a rev sha to pin
    moz-rev = "master";
    moz-url = builtins.fetchTarball { url = "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz"; sha256="1f41psqw00mdcwm28y1frjhssybg6r8i7rpa8jq0jiannksbj27s";};
    nightlyOverlay = (import "${moz-url}/firefox-overlay.nix");
  in [
    nightlyOverlay
  ];

  programs.firefox = {
    enable = true;
    profiles.vitrial = {
      #search.engines = {
      #  "SearX" = {
      #    urls = [{
      #      template = "https://searx.vitrial.xyz/";
      #      params = [
      #        {  name = "q"; value = "{searchTerms}"; }
      #      ];
      #    }];
      #  };
      #};
      search.force = true;
      search.default = "DuckDuckGo";
      #extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #  ublock-origin
      #  sponsor-block
      #  vimium
      #];
    };
    package = pkgs.latest.firefox-nightly-bin;
  };
}
