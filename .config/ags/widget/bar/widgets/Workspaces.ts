const hyprland = await Service.import('hyprland')


const dispatch = ws => hyprland.messageAsync(`dispatch workspace ${ws}`);
const activeId = hyprland.active.workspace.bind("id")

export const Workspaces = () => Widget.EventBox({
  onScrollUp: () => dispatch('+1'),
  onScrollDown: () => dispatch('-1'),
  child: Widget.Box({
    class_name: "workspaces",
    children: Array.from({ length: 6 }, (_, wkspace) => wkspace + 1).map(wkspace => Widget.Button({
      attribute: wkspace,
      label: `${wkspace}`,
      onClicked: () => dispatch(wkspace),
      class_name: activeId.as(i => `${i === wkspace ? "focused" : ""}`),
    })),
  }),
})
