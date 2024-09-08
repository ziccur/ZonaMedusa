
-- All configs explained in the README.md file

Config= {

    location = vector3(1748.0743, 3268.5168, 41.2383),

    allowedJobs = {
        'police',
        'ambulance'
    },

    allowedIllegalJobs = {
        'mechanic'
    },

    NPCspawn = false,
    pedModel = 's_m_y_cop_01', --? https://docs.fivem.net/docs/game-references/ped-models/

    conquerKey = 38, --? https://docs.fivem.net/docs/game-references/controls/

    Size = { 
        x = 100,
        y = 100,
        z = 100
    },

    timeToConquer = 10, --? Time to conquer the zone (seconds)
    timeToReward = 5, --? Time to reward the zone (seconds)

    ilegalReward = {
        cocaine_bag = 1,
        weed_bag = 1,
        meth_bag = 1
    },

    legalReward = {
        --? You can use "money", "bank" or item name as reward
        money = 1000,
        bank = 1000,
        diamond = 1
    },

    BlipColour = 1, 
    BlipSprite = 429, -- https://docs.fivem.net/docs/game-references/blips/
    BlipAlpha = 50, 
    BlipRadius = 100.0, 

    defaultOwner = 'Nobody'

}