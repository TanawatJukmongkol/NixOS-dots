{
  pkgs,
  ...
} : {
  environment.systemPackages = with pkgs; [
    # home manager
    home-manager
    # System utils
    tree
    gzip
    unzip
    brightnessctl
    pulseaudio
    direnv
    bluez
    bluez-tools
    # Manuals
    man-pages
    man-pages-posix
    # Build tools
    gnumake
    cmake
    meson
    # Debuggers
    valgrind
    gdb
    lldb
    # Language servers
    clang
    nixd
    # Common packags
    git
    python3
    # Default minimal text editor
    nano
  ];
}