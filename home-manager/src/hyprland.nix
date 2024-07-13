{
  ...
} : {

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      # debug = { disable_logs = false; };
      misc = {
        disable_hyprland_logo = true;
      };
      exec-once = [
        "hyprpaper"
        "waybar"
        "wl-paste --watch cliphist store"
      ];
      env = [
        "GDK_BACKEND,wayland,x11,remmina"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        "XDG_SESSION_TYPE,wayland"
        "NIXOS_OZONE_WL,y"

        "MOZ_ENABLE_WAYLAND,1"
        "MOZ_DBUS_REMOTE,1"

        "XMODIFIERS,@im=fcitx"
        "QT_IM_MODULE,fcitx"

        #"WLR_NO_HARDWARE_CURSORS,1"
        #"WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"
      ];
      monitor = [
        "eDP-1 , highres, auto, 1.25"
        ", highres, auto, auto"
      ];
      bind = [
        # Terminal
        "CTRL ALT, T, exec, kitty"
        # Exit (temporary)
        "$mod, escape, exec, hyprctl dispatch exit"
        # Lockscreen
        "$mod, L, exec, hyprlock"
        # Clipboard
        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        # Window
        "$mod, C, killactive"
        "$mod, M, fullscreen, 1"
        "$mod, R, togglesplit,"
        "$mod, P, pseudo,"
        "$mod SHIFT, M, fullscreen, 0"
        "$mod, F, togglefloating"
        "$mod, return, exec, rofi -show drun"
        # Move to workspace
        "$mod CTRL, left, workspace, r-1"
        "$mod CTRL, right, workspace, r+1"
        # Move window to workspace
        "CTRL ALT, left, movetoworkspace, r-1"
        "CTRL ALT, right, movetoworkspace, r+1"
        "$mod, left, movefocus, l"
        "$mod, left, bringactivetotop,"
        "$mod, right, movefocus, r"
        "$mod, right, bringactivetotop,"
        "$mod, up, movefocus, u"
        "$mod, up, bringactivetotop,"
        "$mod, down, movefocus, d"
        "$mod, down, bringactivetotop,"

        # submaps
        "ALT CTRL, escape, submap, passthrough"
        "ALT, M, submap, movewindow"
        "ALT, R, submap, resizewindow"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = "on";
        workspace_swipe_distance = "200";
        # workspace_swipe_cancel = "ratio, 0.35";
        workspace_swipe_use_r = "true";
      };
    };
    extraConfig = ''
      submap = passthrough
        bind = ALT CTRL,escape,exec,notify-send -e -u low -a Hyprland "Normal mode"
        bind = ALT CTRL,escape,submap,reset
      submap = movewindow
        binde = , right, movewindow, r
        binde = , left, movewindow, l
        binde = , up, movewindow, u
        binde = , down, movewindow, d
        binde = , l, movewindow, r
        binde = , h, movewindow, l
        binde = , k, movewindow, u
        binde = , j, movewindow, d
        bind = ,escape,exec,notify-send -e -u low -a Hyprland "Normal mode"
        bind= ,catchall,submap,reset
        bind = ,escape,submap,reset
      submap = resizewindow
        binde = , right, resizeactive, 20 0
        binde = , left, resizeactive, -20 0
        binde = , up, resizeactive, 0 -20
        binde = , down, resizeactive, 0 20
        binde = , l, resizeactive, 20 0
        binde = , h, resizeactive, -20 0
        binde = , k, resizeactive, 0 -20
        binde = , j, resizeactive, 0 20
        bind = ,escape,exec,notify-send -e -u low -a Hyprland "Normal mode"
        bind= ,catchall,submap,reset
        bind = ,escape,submap,reset
      ### Reset ###
      submap = reset
    '';
  };
}
