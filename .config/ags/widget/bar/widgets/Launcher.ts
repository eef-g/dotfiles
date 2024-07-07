import { ToggleLauncher } from "widget/AppLauncher";

export const LauncherButton = Widget.Button({
  className: "LauncherButton",
  label: "󰣇",
  onClicked: ToggleLauncher,
})
