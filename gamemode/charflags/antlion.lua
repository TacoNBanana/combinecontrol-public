FLAG.PrintName 					= "Antlion"
FLAG.Flag 						= "E"

FLAG.Team						= TEAM_XEN
FLAG.Loadout					= {"weapon_cc_antlion"}

FLAG.Health						= 200

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 95
FLAG.SpeedOverride.r 			= 300
FLAG.SpeedOverride.c 			= 95
FLAG.SpeedOverride.j 			= 210

function FLAG.ModelFunc(ply)
	return "models/AntLion.mdl"
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_YELLOW)

	ply:SetViewOffset(Vector(0, 0, 30))
	ply:SetViewOffsetDucked(Vector(0, 0, 30))
end

function FLAG.OnDeath(ply)
	ply:StopSound("antlion_flight_loop")
	ply:StopSound("antlion_flight_land")

	ply:SetBodygroup(1, 0)
end

sound.Add({
	name = "antlion_flight_loop",
	channel = CHAN_STREAM,
	volume = 1.0,
	level = 75,
	pitch = 100,
	sound = "npc/antlion/fly1.wav"
})

sound.Add({
	name = "antlion_flight_land",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 75,
	pitch = 100,
	sound = "npc/antlion/land1.wav"
})