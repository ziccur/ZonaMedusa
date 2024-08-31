Config= {}


Config.location = vector3(-1637.1189, 180.4041, 61.7573)
Config.payMethod = "bank" -- bank or cash
Config.spawnPed = true
Config.pedModel = "s_m_y_dealer_01"

Config.options = { 
    {label = "Dinero x2  -  100.000$", value = "opcion1", money = 0, levels = 0, items = 0},
    {label = "Opción 2", value = "opcion2", money = 0, levels = 0, items = 0}
 }
 Config.dataMenu = {
    title = "Mi Menú",
    align = "top-left",
    elements = {}
}

for i = 1, #Config.options do
    Config.dataMenu.elements[i] = {label = Config.options[i].label, value = Config.options[i].value}
end