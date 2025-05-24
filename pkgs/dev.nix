{ config, lib, pkgs, ... }:

{
 environment.systemPackages = with pkgs; [
  # editors
  vim
  neovim
  jetbrains.idea-community-bin # normal is broken
  vscode

  # utilities
  wget
  tmux
  bind
  git
  binutils
  whois
  rustup
  rust-cbindgen
  gnupg
  pinentry
  fd
  ripgrep
  qemu
  unzip
  unrar
  bytecode-viewer

  # debug
  gdb
  valgrind

  # lang/compilers
  gcc13
  rustc
  astyle
  cmake
  gnumake
  go
  nodejs_22
  mono
  python312Packages.pip
  python312Packages.tree-sitter
  python312Packages.pynvim
  rust-cbindgen
  nasm
  maven
  python3
 ];
 
 environment.etc = with pkgs; {
  "jdk".source = jdk;
  "jdk8".source = jdk8;
  "jdk11".source = jdk11;
  "jdk17".source = jdk17;
  "jdk21".source = jdk21;
  "zulu8".source = zulu8;
  "jetbrains_jdk".source = jetbrains.jdk;
  "jetbrains_jdk17".source = jetbrains.jdk-no-jcef-17;
  "jetbrains_jdk21".source = jetbrains.jdk-no-jcef;
 }; 
}
