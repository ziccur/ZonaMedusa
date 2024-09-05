
-- All configs explained in the README.md file

Config= {}

Config.Lenguage = 'en'
Config.location = vector3(1748.0743, 3268.5168, 41.2383)

Config.allowedJobs = {
    'police',
    'ambulance'
}

Config.allowedIllegalJobs = {
    'mechanic'
}

Config.NPCspawn = false
Config.pedModel = 's_m_y_cop_01'--? https://docs.fivem.net/docs/game-references/ped-models/

Config.conquerKey = 38 --? https://docs.fivem.net/docs/game-references/controls/

Config.Size = { 
    x = 100,
    y = 100,
    z = 100
}

Config.timeToConquer = 10 --? Time to conquer the zone (seconds)
Config.timeToReward = 5 --? Time to reward the zone (seconds)

Config.ilegalReward = {
    cocaine_bag = 1,
    weed_bag = 1,
    meth_bag = 1
}

Config.legalReward = {
    --? You can use "money", "bank" or item name as reward
    money = 1000,
    bank = 1000,
    diamond = 1
}

Config.BlipColour = 1 
Config.BlipSprite = 429 -- https://docs.fivem.net/docs/game-references/blips/
Config.BlipAlpha = 50 
Config.BlipRadius = 100.0 

Config.defaultOwner = 'Nobody'

