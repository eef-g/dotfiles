const datetime = Variable("", {
  poll: [1000, 'date "+%l:%M %p"']
})

export default () => Widget.Box({
  vertical: true,
  class_name: "date-column-vertical",
  children: [

    Widget.Box({
      class_name: "clock_box",
      vertical: true,
      children: [
        Widget.Label({
          class_name: "clock",
          label: datetime.bind(),
        }),
      ]
    }),

    Widget.Box({
      class_name: "calendar",
      children: [
        Widget.Calendar({
          hexpand: true,
          hpack: "center",
        }),
      ]
    })
  ]
})
