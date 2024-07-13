# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  # inputs,
  outputs,
  # lib,
  # config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./src/stylix.nix
    ./src/stylix-home.nix
    ./src/hyprland.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # TODO: Set your username
  home = {
    username = "airgeddon1337";
    homeDirectory = "/home/airgeddon1337";
  };

  # Add stuff for your user as you see fit:

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Util
    fastfetch
    waybar
    rofi-wayland
    hyprpaper
    # hyprnome ???
    hyprlock
    hypridle
    hyprpicker
    hyprshot
    wl-clipboard
    cliphist
    # File management
    dolphin
    ark
    # Editors
    vscodium
    # Media
    mpv
    obs-studio
    miru
    yt-dlp
    # Internet / Social media
    firefox
    chromium
    discord
    # VM
    virt-manager
    # Games
    osu-lazer-bin
    # Misc.
    obsidian
    # Fonts
    (nerdfonts.override {
      fonts = [ "Hack" "FiraCode" ];
    })
    tlwg
    noto-fonts-cjk
  	noto-fonts-emoji
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.kitty = {
    enable = true;
    extraConfig = ''
      font_family           FiraCode Nerd Font Mono Reg
      tab_bar_style         powerline
      tab_separator         angle
      tab_activity_symbol   "◉ "
      bell_on_tab           " 󰂚"
      tab_title_template    "{index} {title[title.rfind('/')+1:]}{bell_symbol}"
      enable_audio_bell     false
      background            #060908
      map ctrl+shift+0      change_font_size all 0
      map kitty_mod+t       new_tab_with_cwd
      map kitty_mod+n       new_os_window_with_cwd
      map kitty_mod+enter   new_window_with_cwd
    '';
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      transparent-nvim
      # nvim-treesitter.withAllGrammars
    ];
    extraConfig = ''
      " set			autoindent
      set			smartindent
      set			noexpandtab
      set			tabstop=4
      set			shiftwidth=4
      set			backspace=indent,eol,start
      syntax		on
      set			nu
      set			list
      set			listchars+=space:⋅
      set			listchars+=tab:→\ 
      set			listchars+=eol:↴

      hi Pmenu	ctermfg=white ctermbg=black gui=NONE guifg=white guibg=black
      hi PmenuSel	ctermfg=white ctermbg=blue gui=bold guifg=white guibg=purple
    '';
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "Flat-Remix-Cyan-Dark";
      package = pkgs.flat-remix-icon-theme;
    };
  };

  # programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
