Config= {}

Config.Lenguage = 'en'
Config.location = vector3(1748.0743, 3268.5168, 41.2383)

Config.allowedJobs = {
    'police',
    'ambulance'
}

Config.allowedIllegalJobs = {
    'mafia',
    'cartel'
}

Config.NPCspawn = false
Config.pedModel = 's_m_y_cop_01'

Config.conquerKey = 38 --? Tecla para conquistar la zona

Config.Size = { --? Tamaño de la zona
    x = 100,
    y = 100,
    z = 100
}

Config.timeToConquer = 10 --? Time to conquer the zone (seconds)
Config.timeToReward = 300 --? Time to reward the zone (seconds)

Config.ilegalReward = {
    cocaine_bag = 1,
    weed_bag = 1,
    meth_bag = 1,
}

Config.legalReward = {
    money = 1000,
}

Config.BlipColour = 1 --? Color del blip (rojo)
Config.BlipSprite = 429 --? Icono del blip (icono de la policía)
Config.BlipAlpha = 50 --? Opacidad del blip
Config.range = 100.0 --? Rango del blip

Config.defaultOwner = 'Nobody' --? Dueño por defecto de la zona

