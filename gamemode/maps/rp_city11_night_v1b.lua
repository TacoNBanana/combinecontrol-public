function GM:GetHL2CamPos()
  return { Vector( -3206, -2028, -1044 ), Angle( -36, 114, 0 ) };
end
 
function GM:GetCombineRationPos()
  return { Vector( -2402, 2104, -960 ), Angle( 1, 180, -0 ) };
end
 
 
function GM:GetCombineCratePos()
  return { Vector( -2625, 1401, -743 ), Angle( 1, 90, -0 ) };
end
 
GM.Stoves = {
  { Vector( -4280, -1940, -1136 ), Angle( 0, -90, 0 ), "", false },
  { Vector( -4282, -2424, -1136 ), Angle( 0, 90, 0 ), "", false },
  { Vector( -3956, -2102, -1011 ), Angle( 0, 90, 0 ), "", true },
  { Vector( -4279, -1939, -999 ), Angle( 0, -90, 0 ), "", false },
  { Vector( -4279, -2423, -999 ), Angle( 0, 90, 0 ), "", false },
  { Vector( -3957, -2422, -1011 ), Angle( 0, 90, 0 ), "", true },
  { Vector( -3957, -2422, -875 ), Angle( 0, 90, 0 ), "", true },
  { Vector( -4277, -2423, -864 ), Angle( 0, 90, 0 ), "", false },
  { Vector( -4282, -1938, -864 ), Angle( 0, -90, 0 ), "", false },
  { Vector( -3954, -2422, -739 ), Angle( 0, 90, 0 ), "", true },
  { Vector( -3957, -2102, -739 ), Angle( 0, 90, 0 ), "", true },
  { Vector( -4278, -1940, -727 ), Angle( 0, -90, 0 ), "", false },
  { Vector( -4279, -2425, -727 ), Angle( 0, 90, 0 ), "", false },
  { Vector( -2641, -2659, -1315 ), Angle( 0, 180, 0 ), "", true },
  { Vector( -4305, 487, -955 ), Angle( 0, 180, 0 ), "", true },
  { Vector( -4041, 630, -955 ), Angle( 0, 180, 0 ), "", true },
  { Vector( -4041, 630, -819 ), Angle( 0, 180, 0 ), "", true },
  { Vector( -4305, 486, -819 ), Angle( 0, 180, 0 ), "", true },
  { Vector( -4041, 630, -683 ), Angle( 0, 180, 0 ), "", true },
  { Vector( -4305, 486, -683 ), Angle( 0, 180, 0 ), "", true },
  { Vector( -5014, -1860, -1179 ), Angle( 0, 0, 0 ), "", true },
  { Vector( -5013, -1861, -1043 ), Angle( 0, 0, 0 ), "", true },
  { Vector( -5014, -1860, -907 ), Angle( 0, 0, 0 ), "", true },
  { Vector( -5014, -1860, -771 ), Angle( 0, 0, 0 ), "", true },
  { Vector( -2833, -3323, -1059 ), Angle( 0, -180, 0 ), "", true },
  { Vector( -2833, -3459, -1059 ), Angle( 0, 180, 0 ), "", true },
  { Vector( -2289, -4093, -1055 ), Angle( 0, -180, 0 ), "", true },
  { Vector( -5449, -541, -1059 ), Angle( 0, 180, 0 ), "", true },
};
 
GM.CombineSpawnpoints = {
  Vector( -3034, 2389, -791 ),
  Vector( -2982, 2321, -791 ),
  Vector( -2995, 2391, -791 ),
  Vector( -2984, 2451, -791 ),
  Vector( -3035, 2451, -791 ),
  Vector( -3036, 2330, -791 ),
};
 
GM.DoorData = {
  { Vector( -3616, -2372, -1104 ), DOOR_COMBINEOPEN, "Tunnel Checkpoint" },
  { Vector( -3622, -1720, -1114 ), DOOR_BUYABLE, "Souvenirs Shop", 5 },
  { Vector( -3700, -1320, -1114 ), DOOR_COMBINEOPEN, "Distribution" },
  { Vector( -1244, -796, -1320 ), DOOR_COMBINEOPEN, "Metro Checkpoint" },
  { Vector( -1316, -880, -1320 ), DOOR_COMBINEOPEN, "Questioning" },
  { Vector( -1900, -1436, -1052 ), DOOR_UNBUYABLE, "", 5, "WH" },
  { Vector( -3990, -2032, -842 ), DOOR_COMBINEOPEN, "CCH-A Control", 2 },
  { Vector( -1720, -796, -826 ), DOOR_COMBINEOPEN, "Overwatch" },
  { Vector( -1468.0300292969, -744, -840 ), DOOR_COMBINEOPEN, "CCA D2 Outpost" },
  { Vector( -4848, 27.989999771118, -912 ), DOOR_COMBINEOPEN, "D3 Outpost - CCH-B Exit" },
  { Vector( -3019.9899902344, 1592, -736 ), DOOR_COMBINEOPEN, "Control" },
  { Vector( -2811.9899902344, 1648, -736 ), DOOR_COMBINEOPEN, "Armory" },
  { Vector( -3327.9899902344, 972.01000976563, -672 ), DOOR_COMBINEOPEN, "Nexus" },
  { Vector( -3400, 1624, -666 ), DOOR_COMBINEOPEN, "Administration" },
  { Vector( -2888, 1788.0100097656, -736 ), DOOR_COMBINEOPEN, "RESTRICTED ACCESS" },
  { Vector( -2808.0100097656, 1148, -980 ), DOOR_COMBINEOPEN, "Detainment" },
  { Vector( -2151.9899902344, 1444.0100097656, -800 ), DOOR_COMBINEOPEN, "101 Observation" },
  { Vector( -2612.0100097656, 840, -1000 ), DOOR_COMBINEOPEN, "Observation" },
  { Vector( -2739, 1316, -1001.75 ), DOOR_COMBINELOCK, "Cell 1" },
  { Vector( -2587, 1316, -1001.75 ), DOOR_COMBINELOCK, "Cell 2" },
  { Vector( -2435, 1316, -1001.75 ), DOOR_COMBINELOCK, "Cell 3" },
  { Vector( -2612, 917, -1001.75 ), DOOR_COMBINELOCK, "Cell 5" },
  { Vector( -2484, 917, -1001.75 ), DOOR_COMBINELOCK, "Cell 4" },
  { Vector( -2469, 764, -1001.75 ), DOOR_COMBINELOCK, "Questioning" },
  { Vector( -2179, 1460, -938 ), DOOR_COMBINELOCK, "Room 101" },
  { Vector( -2131, 1212, -737.75 ), DOOR_COMBINELOCK, "Detainment Control" },
  { Vector( -4795.990234375, -208, -896 ), DOOR_COMBINEOPEN, "D3 Outpost" },
  { Vector( -5648, -1604, -1144 ), DOOR_BUYABLE, "Container 263669", 1 },
  { Vector( -5788, -1176, -1132 ), DOOR_COMBINELOCK, "ULC Workshop" },
  { Vector( -5101, -1284, -1154 ), DOOR_COMBINELOCK, "D3 Housing" },
  { Vector( -2808.0100097656, 1174, -980 ), DOOR_COMBINEOPEN, " " },
  { Vector( -2808.0100097656, 1126, -980 ), DOOR_COMBINEOPEN, "  " },
  { Vector( -5204, -395, -962 ), DOOR_BUYABLE, "'The Shack'", 3, "TS" },
  { Vector( -5716, -443, -1026 ), DOOR_UNBUYABLE, "Restroom", 3, "TS" },
  { Vector( -4669, -1580, -1146 ), DOOR_BUYABLE_ASSIGNABLE, "D3-1", 2 },
  { Vector( -4669, -1580, -1010 ), DOOR_BUYABLE_ASSIGNABLE, "D3-2", 2 },
  { Vector( -1532, -917, -1090 ), DOOR_COMBINELOCK, "CCA D2 Outpost" },
  { Vector( -1908, -1339, -1050 ), DOOR_BUYABLE, "Warehouse", 5, "WH" },
  { Vector( -2021, -1356, -1050 ), DOOR_UNBUYABLE, "Garage", 0, "WH" },
  { Vector( -1740, -1947, -994 ), DOOR_BUYABLE, "Abandoned Building", 5 },
  { Vector( -3264, 916.01000976563, -976 ), DOOR_COMBINEOPEN, "Sector 11 Nexus" },
  { Vector( -3264, 1044.0100097656, -976 ), DOOR_COMBINEOPEN, "Inner Airlock" },
  { Vector( -3068, -1684, -1106 ), DOOR_BUYABLE, "Shop Diordna", 5, "SD" },
  { Vector( -3100, -460, -986 ), DOOR_BUYABLE, "Unmeht", 5, "UM" },
  { Vector( -3711, -1913, -1114 ), DOOR_COMBINELOCK, "CCH-A" },
  { Vector( -3711, -2007, -1114 ), DOOR_COMBINELOCK, "CCH-A" },
  { Vector( -2709, -596, -986 ), DOOR_UNBUYABLE, "Backroom", 5, "UM" },
  { Vector( -2613, -1228, -1114 ), DOOR_UNBUYABLE, "Garage", 5, "TX" },
  { Vector( -2588, -1325, -1114 ), DOOR_UNBUYABLE, "Storage", 5, "TX" },
  { Vector( -2884, -181, -986 ), DOOR_BUYABLE, "Abandoned FOTO", 1 },
  { Vector( -3940, -20.999799728394, -922 ), DOOR_COMBINELOCK, "Front Desk" },
  { Vector( -4067, 420, -922 ), DOOR_BUYABLE_ASSIGNABLE, "B-1-1", 2 },
  { Vector( -4203, 420, -922 ), DOOR_BUYABLE_ASSIGNABLE, "B-1-2", 2 },
  { Vector( -4531, 420, -922 ), DOOR_BUYABLE_ASSIGNABLE, "B-1-3", 2 },
  { Vector( -4429, 228, -922 ), DOOR_BUYABLE_ASSIGNABLE, "B-1-4", 2 },
  { Vector( -4067, 420, -786 ), DOOR_BUYABLE_ASSIGNABLE, "B-2-1", 2 },
  { Vector( -4531, 420, -786 ), DOOR_BUYABLE_ASSIGNABLE, "B-2-3", 2 },
  { Vector( -4203, 420, -786 ), DOOR_BUYABLE_ASSIGNABLE, "B-2-2", 2 },
  { Vector( -4429, 228, -786 ), DOOR_BUYABLE_ASSIGNABLE, "B-2-4", 2 },
  { Vector( -4067, 420, -650 ), DOOR_BUYABLE_ASSIGNABLE, "B-3-1", 2 },
  { Vector( -4531, 420, -650 ), DOOR_BUYABLE_ASSIGNABLE, "B-3-3", 2 },
  { Vector( -4203, 420, -650 ), DOOR_BUYABLE_ASSIGNABLE, "B-3-2", 2 },
  { Vector( -4429, 228, -650 ), DOOR_BUYABLE_ASSIGNABLE, "B-3-4", 2 },
  { Vector( -4148, -2131, -1113.75 ), DOOR_BUYABLE_ASSIGNABLE, "A-1-1", 2 },
  { Vector( -4148, -2267, -1113.75 ), DOOR_BUYABLE_ASSIGNABLE, "A-1-2", 2 },
  { Vector( -4148, -2131, -977.75 ), DOOR_BUYABLE_ASSIGNABLE, "A-2-4", 2 },
  { Vector( -4148, -2267, -977.75 ), DOOR_BUYABLE_ASSIGNABLE, "A-2-2", 2 },
  { Vector( -4148, -2131, -841.75 ), DOOR_BUYABLE_ASSIGNABLE, "A-3-4", 2 },
  { Vector( -4148, -2267, -841.75 ), DOOR_BUYABLE_ASSIGNABLE, "A-3-2", 2 },
  { Vector( -4148, -2131, -705.75 ), DOOR_BUYABLE_ASSIGNABLE, "A-4-4", 2 },
  { Vector( -4148, -2267, -705.75 ), DOOR_BUYABLE_ASSIGNABLE, "A-4-2", 2 },
  { Vector( -3988, -2315, -977.75 ), DOOR_BUYABLE_ASSIGNABLE, "A-2-1", 2 },
  { Vector( -3988, -2011, -977.75 ), DOOR_BUYABLE_ASSIGNABLE, "A-2-3", 2 },
  { Vector( -3988, -2315, -841.75 ), DOOR_BUYABLE_ASSIGNABLE, "A-3-1", 2 },
  { Vector( -3988, -2011, -705.75 ), DOOR_BUYABLE_ASSIGNABLE, "A-4-3", 2 },
  { Vector( -3988, -2315, -705.75 ), DOOR_BUYABLE_ASSIGNABLE, "A-4-1", 2 },
  { Vector( -2717, -2628, -1282 ), DOOR_UNBUYABLE, "Storage", 6, "LL" },
  { Vector( -2533, -2628, -1282 ), DOOR_UNBUYABLE, "Restroom", 6, "LL" },
  { Vector( -2685, -2380, -1282 ), DOOR_BUYABLE, "Lad's Lounge", 6, "LL" },
  { Vector( -2779, -2380, -1282 ), DOOR_BUYABLE, "Lad's Lounge", 6, "LL" },
  { Vector( -3804, 171, -922 ), DOOR_COMBINELOCK, "CCH-B" },
  { Vector( -4669, -1580, -874 ), DOOR_BUYABLE_ASSIGNABLE, "D3-3", 2 },
  { Vector( -4669, -1580, -738 ), DOOR_BUYABLE_ASSIGNABLE, "D3-4", 2 },
  { Vector( -2156, -3779, -1194 ), DOOR_BUYABLE, "Shop", 5, "NN" },
  { Vector( -2132, -3299, -1194 ), DOOR_COMBINELOCK, "D2 Housing" },
  { Vector( -2747, -3252, -1194 ), DOOR_UNBUYABLE, "Storage" },
  { Vector( -2812, -3243, -1026 ), DOOR_BUYABLE_ASSIGNABLE, "D2-1", 2 },
  { Vector( -2812, -3581, -1026 ), DOOR_BUYABLE_ASSIGNABLE, "D2-2", 2 },
  { Vector( -2325, -3548, -1026 ), DOOR_BUYABLE_ASSIGNABLE, "D2-3", 2 },
  { Vector( -2621, -2860, -1114 ), DOOR_BUYABLE, "Storage", 5 },
  { Vector( -4837, -1532, -602 ), DOOR_COMBINELOCK, "Roof Access" },
  { Vector( -3060, -1272, -1114 ), DOOR_BUYABLE, "Texhnka", 5, "TX" },
  { Vector( -1268, -684, -1088 ), DOOR_COMBINEOPEN, "Nexus Access" },
  { Vector( -2052, 1140, -1000 ), DOOR_COMBINEOPEN, "D2 Outpost Access" },
  { Vector( -2888, 2288.0200195313, -736 ), DOOR_COMBINEOPEN, "Nexus" },
  { Vector( -2744, 2272.0200195313, -1000 ), DOOR_COMBINEOPEN, "Medbay" },
  { Vector( -2484, -3675, -1194 ), DOOR_UNBUYABLE, "Backroom", 5, "NN" },
  { Vector( -3100, -1096, -1112 ), DOOR_BUYABLE, "Texhnka Garage", 5, "TX" },
  { Vector( -2916, -1827, -1106 ), DOOR_UNBUYABLE, "Backroom", 5, "SD" },
  { Vector( -3503.9899902344, 1884.0100097656, -664 ), DOOR_COMBINEOPEN, "Administration" },
  { Vector( -3687.9899902344, 2140.0100097656, -664 ), DOOR_COMBINEOPEN, "Broadcasting" },
  { Vector( -3188.0100097656, 1155.9899902344, -976 ), DOOR_COMBINEOPEN, "Sector 11 Nexus" },
  { Vector( -4421, -708, -1170 ), DOOR_COMBINELOCK, "SMU Access Hub" },
};
 
GM.EnableAreaportals = true;
 
GM.CurrentLocation = LOCATION_CITY;
function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(-1086, -2329, -1167), LOCATION_CANAL, 128, TRANSITPORT_CITY_GATE)
	self:CreateLocationPoint(Vector(-3432, -1713, -1517), LOCATION_CANAL, 256, TRANSITPORT_CITY_SEWER)
	self:CreateLocationPoint(Vector(-3119, 2559, -727), LOCATION_CANAL, 256, TRANSITPORT_CITY_COMBINE)
end
 
GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "The combine lock on the door is deactivated. You could slide right through.. but where could it go?"
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "The sewer pipe takes a steep downward turn from here. Who knows where it could lead."
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "The razer train is prepped and ready to take you to a faraway land."

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector(-1428, -2192, -1089),
	Vector(-1372, -2191, -1089),
	Vector(-1300, -2190, -1089),
	Vector(-1234, -2189, -1089),
}
 
GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector(-3733, -1490, -1517),
	Vector(-3732, -1445, -1517),
	Vector(-3730, -1387, -1517),
	Vector(-3728, -1325, -1517),
}

GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = {
	Vector(-2554, 2028, -984),
	Vector(-2647, 2024, -981),
	Vector(-2614, 2146, -980),
	Vector(-2502, 2150, -977),
}

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")