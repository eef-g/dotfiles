{ inputs, pkgs, ...}:
let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  plugins = inputs.hyprland-plugins.packages.${pkgs.system};
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  # Imported custom settings (This just makes it easier to change custom settings)
  custom = import ../custom/hyprland-custom.nix;
in
{
  options = {
    layout = {
      type = "bool";
      default = false;
      description = "The layout of the monitors for Hyprland.";
    };
  };

  xdg.desktopEntries."org.gnome.Settings" = {
      name = "Settings";
      comment = "Gnome Control Center";
      icon = "org.gnome.Settings";
      exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
      categories = [ "X-Preferences" ];
      terminal = false;
  };

  wayland.windowManager.hyprland = {
      enable = true;
      package = hyprland;
      systemd.enable = true;
      xwayland.enable = true;

      settings = {
        exec-once = [
          "ags -b hypr"
          "hyprctl setcursor Adwaita 24"
        ];

        # Monitor setup -- uses the layout option
        monitor = if options.use-custom == false then
        [
          # Automatically detect the monitors and set them up
          ",preferred,auto,auto"
        ] else
        custom.monitor;

        workspace = if options.layout == false then
        [
          # Automatically detect the monitors and set them up
          "auto"
        ]
        else
        custom.workspace;

        general = {
          layout = "dwindle";
          resize_on_border = true;
        };

        misc = {
          disable_splash_rendering = true;
          force_default_wallpaper = 1;
        };

        input = {
          kb_layout = "us";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = "yes";
            disable_while_typing = true;
            drag_lock = true;
          };
          sensitivity = 0;
          float_switch_override_focus = 2;
        };

        binds = {
          allow_workspace_cycles = true;
        };

        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };

        gestures = {
          workspace_swipe = false;
          workspace_swipe_forever = false;
          workspace_swipe_numbered = false;
        };

        # Put any application name with the following syntax
        # To make it automatically float when opened:
        # (f <APPLICATION_NAME>)
        windowrule = let
          f = regex: "float, ^(${regex})$";
        in [
          (f "org.gnome.Settings")
          (f "Color Picker")
          (f "org.gnome.Calculator")
          (f "org.gnome.Nautilus")
          (f "nm-connection-editor")
          (f "xdg-desktop-portal")
          (f "xdg-desktop-portal-gnome")
          (f "transmission-gtk")
          (f "com.github.Aylur.ags")
        ];

        bind = let
          binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
          mvfocus = binding "SUPER" "movefocus";
          ws = binding "SUPER" "workspace";
          resizeactive = binding "SUPER CTRL" "resizeactive";
          mvactive = binding "SUPER ALT" "moveactive";
          mvtows = binding "SUPER SHIFT" "movetoworkspace";
          ags_e = "exec, ags -b hypr";
          arr = [1 2 3 4 5 6 7 8 9];
        in [
          # App Shortcuts
          "CTRL SHIFT, R, ${ags_e} quit; ags -b hypr"
          "SUPER, Space,  ${ags_e} -t applauncher"
          "SUPER, Tab,    ${ags_e} -t overview"
          ",XF86PowerOff, ${ags_e} -r 'powermenu.shutdown()'"
          "SUPER SHIFT, S, ${ags_e} -r 'recorder.screenshot(true)'"
          "SUPER, Return, exec, kitty"
          "SUPER, W, exec, brave"
          # Window Behavior
          "SUPER, Q, killactive"
          "SUPER, V, togglefloating"
          "SUPER, F, fullscreen"
          "SUPER, J, togglesplit"
          # Window Navigation
          (mvfocus "k" "u")
          (mvfocus "j" "d")
          (mvfocus "l" "r")
          (mvfocus "h" "l")
          (ws "left" "e-1")
          (ws "right" "e+1")
          (mvtows "left" "e-1")
          (mvtows "right" "e+1")
          (resizeactive "k" "0 -20")
          (resizeactive "j" "0 20")
          (resizeactive "l" "20 0")
          (resizeactive "h" "-20 0")
          (mvactive "k" "0 -20")
          (mvactive "j" "0 20")
          (mvactive "l" "20 0")
          (mvactive "h" "-20 0")
        ]
        ++ (map (i: ws (toString i) (toString i)) arr)
        ++ (map (i: mvtows (toString i) (toString i)) arr);

        bindle = [
          ",XF86MonBrightnessUp,   exec, ${brightnessctl} set +5%"
          ",XF86MonBrightnessDown, exec, ${brightnessctl} set  5%-"
          ",XF86KbdBrightnessUp,   exec, ${brightnessctl} -d asus::kbd_backlight set +1"
          ",XF86KbdBrightnessDown, exec, ${brightnessctl} -d asus::kbd_backlight set  1-"
          ",XF86AudioRaiseVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
          ",XF86AudioLowerVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
        ];

      bindl =  [
        ",XF86AudioPlay,    exec, ${playerctl} play-pause"
        ",XF86AudioStop,    exec, ${playerctl} pause"
        ",XF86AudioPause,   exec, ${playerctl} pause"
        ",XF86AudioPrev,    exec, ${playerctl} previous"
        ",XF86AudioNext,    exec, ${playerctl} next"
        ",XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
      ];

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];

    };
  };
}

