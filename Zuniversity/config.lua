Config= {}

Config.location = vector3(-1637.1189, 180.4041, 61.7573) -- location of the point, ped, etc
Config.payMethod = "money" -- bank or money
Config.spawnPed = true -- true or false
Config.pedModel = "s_m_y_dealer_01" -- ped model https://wiki.rage.mp/index.php?title=Peds

Config.options = { 
    {label = "Dinero x2  -  100.000$", value = "option1", money = 100000, levels = 0, items = 0},
    {label = "Opción 2", value = "option2", money = 0, levels = 0, items = 0}
 }
 Config.dataMenu = {
    title = "Mi Menú", -- menu title
    align = "top-left", -- menu position
    elements = {} -- don't touch
}
for i = 1, #Config.options do Config.dataMenu.elements[i] = {label = Config.options[i].label, value = Config.options[i].value} end