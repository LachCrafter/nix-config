{ config, lib, pkgs, ... }:

{
 programs.zsh = {
  enable = true;
  ohMyZsh = {
   enable = true; # Optional: Enables Oh My Zsh
   theme = "eastwood";
   plugins = [ "git" "z" "sudo" ];
  };

  enableCompletion = true;
  syntaxHighlighting.enable = true;
  autosuggestions.enable = true;
 };
}
