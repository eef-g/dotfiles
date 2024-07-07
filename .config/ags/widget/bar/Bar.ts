/*****************************************
 __          ___     _            _       
 \ \        / (_)   | |          | |      
  \ \  /\  / / _  __| | __ _  ___| |_ ___ 
   \ \/  \/ / | |/ _` |/ _` |/ _ \ __/ __|
    \  /\  /  | | (_| | (_| |  __/ |_\__ \
     \/  \/   |_|\__,_|\__, |\___|\__|___/
                        __/ |             
                       |___/              
*****************************************/
import { Workspaces } from "./widgets/Workspaces"
import { Volume } from "./widgets/Volume"
import { BatteryLabel } from "./widgets/Battery"
import { Clock } from "./widgets/Clock"
import { SysTrayButton } from "widget/tray/TrayButton"
import { LauncherButton } from "./widgets/Launcher"

/******************************************************
  ____               _                             _   
 |  _ \             | |                           | |  
 | |_) | __ _ _ __  | |     __ _ _   _  ___  _   _| |_ 
 |  _ < / _` | '__| | |    / _` | | | |/ _ \| | | | __|
 | |_) | (_| | |    | |___| (_| | |_| | (_) | |_| | |_ 
 |____/ \__,_|_|    |______\__,_|\__, |\___/ \__,_|\__|
                                  __/ |                
                                 |___/                 
******************************************************/
function Left() {
  return Widget.Box({
    spacing: 8,
    children: [
      LauncherButton,
      Workspaces(),
      SysTrayButton,
    ],
  })
}

function Center() {
  return Widget.Box({
    spacing: 8,
    children: [
      Clock(),
    ],
  })
}

function Right() {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [
      BatteryLabel(),
      Volume(),
    ],
  })
}

export function Bar(monitor = 0) {
  return Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(),
      end_widget: Right(),
    }),
  })
}


