export const PowerButton = () => Widget.Button({
  on_clicked: OpenPowerMenu,
  label: "󰐥"
});

function OpenPowerMenu() {
  Utils.exec("wlogout --protocol layer-shell")
}
