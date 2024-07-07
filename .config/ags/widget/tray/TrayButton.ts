import { ToggleSysTray } from "./TrayWindow"
const systemtray = await Service.import("systemtray")
const items = systemtray.bind("items");

export const SysTrayButton = Widget.Button({
  class_name: "Tray",
  label: "⌄",
  on_clicked: ToggleSysTray,
  visible: items.as(i => i.length > 0 ? true : false)
})
