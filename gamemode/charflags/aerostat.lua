FLAG.PrintName 					= "Aerostat"
FLAG.Flag 						= "T"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"trp_skynet_scanner"}

FLAG.BodyArmor 					= 400

FLAG.UseCombineRadio 			= true
FLAG.IgnoreTravelRestriction 	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.CanAccessCombineMenu 		= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 300
FLAG.SpeedOverride.r 			= 300
FLAG.SpeedOverride.c 			= 0
FLAG.SpeedOverride.j 			= 0

FLAG.CanUseNightvision 			= true

FLAG.SpawnOffset 				= Vector(0, 0, 25)


function FLAG.ModelFunc( ply )
	return "models/combine_scanner.mdl"
end

function FLAG.SetupMove(ply, move, cmd)
	--Fix for admins physgunning scanners
	local moveType = ply:GetMoveType()

	if moveType ~= MOVETYPE_NOCLIP and moveType ~= MOVETYPE_FLY then
		ply:SetMoveType(MOVETYPE_FLY)
	end

	local bobamount = Vector(math.sin(CurTime()) / 12,math.cos(CurTime()) / 12, math.sin(CurTime()) / 20)

	move:SetVelocity(Vector(ply:GetVelocity().x * 0.95 + bobamount.x, ply:GetVelocity().y * 0.95 + bobamount.y, ply:GetVelocity().z * 0.90 + bobamount.z))

	if cmd:KeyDown(IN_JUMP) then
		move:SetVelocity(Vector(ply:GetVelocity().x * 0.98, ply:GetVelocity().y * 0.98, ply:GetVelocity().z * 0.90 + 10))
	end

	if cmd:KeyDown(IN_SPEED) then
		move:SetVelocity(Vector(ply:GetVelocity().x * 0.98, ply:GetVelocity().y * 0.98, ply:GetVelocity().z * 0.90 - 10))
	end
end

function FLAG.OnSpawn(ply)
	ply:SetMoveType(MOVETYPE_FLY)

	ply:SetViewOffset(Vector(0, 0, 10))
	ply:SetViewOffsetDucked(Vector(0, 0, 10))

	ply:EmitSound("scanner_loop")

	ply:SetBloodColor(DONT_BLEED)

	ply:SetHull(Vector(-16, -16, -16), Vector(16, 16, 16))

	ply:SetMoveCollide(MOVECOLLIDE_FLY_BOUNCE)

	ply:SetGravity(0)
end

function FLAG.OnDeath(ply)
	local explo = ents.Create( "env_explosion" )
	explo:SetPos( ply:GetPos() )
	explo:SetKeyValue( "spawnflags", "1" )
	explo:Spawn()
	explo:Activate()
	explo:Fire( "Explode" )

	ply:StopSound("scanner_loop")
	ply:EmitSound("npc/scanner/scanner_siren1.wav")

	EmitSentence( "METROPOLICE_DIE" .. math.random( 0, 8 ), ply:GetPos(), ply:EntIndex(), 0, 0.5, 100, 0, 100 ) -- Kind of want this to be replaced with the TNB CCA version, if possible
end

sound.Add( {
	name = "scanner_loop",
	channel = CHAN_STREAM,
	volume = 1.0,
	level = 40,
	pitch = {110, 180},
	sound = "npc/scanner/scanner_scan_loop1.wav"
} )
