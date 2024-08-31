Config= {}

Config.Lenguage = 'en'
Config.location = vector3(1748.0743, 3268.5168, 41.2383)

Config.allowedJobs = {
    'police',
    'ambulance'
}

Config.NPCspawn = true
Config.pedModel = 's_m_y_cop_01'

Config.Size = { --? Tamaño de la zona
    x = 100,
    y = 100,
    z = 100
}

Config.timeToConquer = 300 --? Tiempo en segundos para conquistar la zona
Config.timeToReward = 300 --? Cada cuantos segundos dar la recompensa 

Config.rewardGangs = {
    cocaine_bag = 1,
    weed_bag = 1,
    meth_bag = 1,
}

Config.rewardPolice = {
    money = 1000,
}

Config.BlipColour = 1 --? Color del blip (rojo)
Config.BlipSprite = 429 --? Icono del blip (icono de la policía)
Config.BlipAlpha = 50 --? Opacidad del blip
Config.range = 100.0 --? Rango del blip

Config.defaultOwner = 'No conquistado'

