const battery = await Service.import("battery")

export function BatteryLabel() {
  const icon = battery.bind("percent").as(p =>
    `battery-level-${Math.floor(p / 10) * 10}-symbolic`)

  const label = Utils.merge([battery.bind("percent").as(p => p > 0 ? p : 0), battery.bind("time_remaining")],
    (per, time) => {
      const hours = Math.floor(time / 3600);
      const diff = (time / 3600) - hours;
      const minutes = Math.floor(60 * diff);
      return `${per}% - ${hours}h ${minutes}m`;
    })

  return Widget.Box({
    class_name: "battery",
    visible: battery.bind("available"),
    children: [
      Widget.Icon({ icon }),
      Widget.Label({
        label: label,
        //label: battery.bind("percent").as(p => p > 0 ? p : 0).as(percent => `${percent}%`)
      }),
    ],
  })
}


