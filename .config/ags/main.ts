
import { applauncher } from "widget/AppLauncher"
import { NotificationPopups } from "widget/Notifications"
import { Bar } from "widget/bar/Bar"
import { DateMenuWindow } from "widget/datemenu/DM_Window"
import { SysTrayWindow } from "widget/tray/TrayWindow"

App.config({
  style: "./style.css",
  windows: [
    Bar(),
    NotificationPopups(),
    applauncher,
    DateMenuWindow,
    SysTrayWindow,
  ],
})

export { }
