# This is where the custom hyprland configuration is stored
# Below are the default custom configurations -- change these for your personal setup
{
  # Custom monitor layout
  monitor = 
  [
    #<MONITOR_NAME>,<RESOLUTION>,<PLACEMENT>,<SCALE>
    # Example:
    # eDP-1, 1920x1080, 0x0, 1
    "DP-1,1920x1080,0x0,auto"
    "DVI-D-1,1920x1080,1920x0,auto"
  ];
  # Custom workspace layout
  workspace =
  [
    #<WORKSPACE>,MONITOR:<MONITOR_NAME>
    "1, monitor:DP-1"
    "2, monitor:DVI-D-1"
    "3, monitor:DP-1"
    "4, monitor:DVI-D-1"
    "5, monitor:DP-1"
    "6, monitor:DVI-D-1"
  ];
};