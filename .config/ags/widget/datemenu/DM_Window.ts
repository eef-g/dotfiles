import DateColumn from "./DateColumn";
// Import Notification Column eventually

const Settings = () => Widget.Box({
  class_name: "datemenu horizontal",
  vexpand: false,
  children: [
    //NotificationColumn,
    Widget.Separator({ orientation: 1 }),
    DateColumn(),
  ]
})

export const DateMenuWindow = Widget.Window({
  name: "DateMenu",
  anchor: ["top"],
  setup: self => self.keybind("Escape", () => {
    App.closeWindow("DateMenu");
  }),
  visible: false,
  keymode: "exclusive",
  child: Settings()
})

export function SpawnDateMenu() {
  DateMenuWindow.visible = !DateMenuWindow.visible;
}
