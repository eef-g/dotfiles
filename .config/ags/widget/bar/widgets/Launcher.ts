import { ToggleLauncher } from "widget/AppLauncher";

export function LauncherButton() {
  return Widget.Button({
    className: "LauncherButton",
    label: "󰣇",
    onClicked: ToggleLauncher,
  });
}
