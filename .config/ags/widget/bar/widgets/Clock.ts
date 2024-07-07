import { SpawnDateMenu } from "../../datemenu/DM_Window"

const datetime = Variable("", {
  poll: [1000, 'date "+%l:%M %p - %b. %e"']
})


export function Clock() {
  return Widget.Button({
    class_name: "clockBox",
    label: datetime.bind(),
    onClicked: SpawnDateMenu,
  })
}
