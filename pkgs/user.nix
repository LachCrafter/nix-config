{ config, lib, pkgs, ... }:

{
 environment.systemPackages = with pkgs; [
  # shell
  neofetch
  fastfetch
  parted
  ntfs3g
  
  # games
  prismlauncher

  # browsers
  floorp

  # messaging
  discord
  element-desktop
  slack
  
  # multimedia
  vlc
  obs-studio
  gimp
  gpu-screen-recorder
  gpu-screen-recorder-gtk
  kdePackages.kdenlive
  spotify
  texliveFull

  # misc
  iotas
  libreoffice-fresh
  filezilla
  pavucontrol
  gnome-tweaks
  qlcplus
  errands
 ];

 # Mullvad vpn
 services.mullvad-vpn = {
  enable = true;
  package = pkgs.mullvad-vpn; 
 };

 fonts.packages = with pkgs; [
  jetbrains-mono
  corefonts
  vistafonts
  adwaita-fonts
  noto-fonts
  noto-fonts-cjk-sans
  comic-mono
  ubuntu_font_family
 ];
}
