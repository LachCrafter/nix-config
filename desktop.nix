{ config, lib, pkgs, ... }:

{
 # time zone
 time.timeZone = "Europe/Berlin";

 # desktop environment
 services.xserver = {
  enable = true;
  xkb.layout = "de";
  desktopManager.gnome.enable = true;
  displayManager.gdm.enable = true;
 };
 
 # cosmic
 services.desktopManager.cosmic.enable = true;

 # audio
 services.pipewire = {
  enable = true;
  pulse.enable = true;
 };
}
