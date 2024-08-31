Config= {}


Config.location = vector3(-1637.1189, 180.4041, 61.7573)
Config.payMethod = "bank" -- bank or cash
Config.spawnPed = true
Config.pedModel = "s_m_y_dealer_01"

Config.options = { 
    {label = "Dinero x2", value = "opcion1", money = 0, levels = 0, items = 0},
    {label = "Opción 2", value = "opcion2", money = 0, levels = 0, items = 0}
 }

 Config.dataMenu = {
    title = "Mi Menú",
    align = "top-left",
    elements = {
        {label = Config.options[1].label, value = "opcion1"}, -- Usar el label de Config.options
        {label = Config.options[2].label, value = "opcion2"}  -- Usar el label de Config.options
    }
}