Config = {}

Config.Locale = 'en'
Config.RandomZones = true -- random zones in delay 
Config.RandomZonesChance = 50 

Config.NPC = {
    {
        Type = 'Search',
        Coords = vector3(-1699.993, -219.251, 56.631),
        active = true, -- put this true if you want a NPC
        heading = 356.767, -- set the heading where the NPC should look at
        model = 's_m_m_doctor_01', -- look here what you want for a NPC https://docs.fivem.net/docs/game-references/ped-models/
        PropName = 'm23_1_prop_m31_artifact_01a',
        PropHelpDistance = 15,
        PropEffect = true, -- easier way to find a artifact
        PropCount = 5,
        SpawnCoordsProps= {
            vector4(-1746.628, -224.524, 55.088, 71.398),
            vector4(-1783.026, -226.152, 52.173, 110.466),
            vector4(-1766.798, -260.551, 49.229, 217.459),
            vector4(-1759.302, -288.099, 46.814, 250.202),
            vector4(-1771.463, -288.705, 45.813, 333.604)
            -- vector4(-1692.081, -230.117, 56.109, 320.092),
            -- vector4(-1695.944, -234.969, 55.525, 136.564),
            -- vector4(-1700.409, -240.212, 54.755, 140.017),
            -- vector4(-1705.597, -245.524, 53.951, 138.436),
            -- vector4(-1710.620, -250.153, 53.276, 132.605)
        }
    }
}

Config.Language = {
    ['en'] = {
        ['press_interact'] = 'Press ~INPUT_PICKUP~ to play a game.',
        ['press_investigate'] = 'You have discovered an artifact, press ~INPUT_PICKUP~ to examine it....',
        ['search_counter'] = 'You still have to %s find artifacts...',
        ['doctor_voice_line_1'] = 'Here is a Bloodymary free...',
        ['doctor_voice_line_2'] = 'HAHAHA fell in my victim, now sleep and look for me %s artifacts on the right part of the graveyard.',
        ['doctor_voice_line_3'] = 'And how was my pill?, heres a little thank you from me....',
        ['near_artifact'] = 'You are in the vicinity of an artifact come keep your eyes open find it!',
        ['search_finished'] = 'You have found all the artifacts... now return to me!',

    }
}
