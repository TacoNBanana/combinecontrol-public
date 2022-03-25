FLAG.PrintName 					= "T-20 Reprog"
FLAG.NameFormat 				= "T20.%s"

FLAG.Flag 						= "a"

FLAG.Health 					= 200
FLAG.ArmorValue 				= 30

FLAG.Team						= TEAM_REPROG

FLAG.Loadout 					= {"trp_t20", "trp_t20_repair", "trp_t20_light"}

FLAG.Scale 						= 0.2

FLAG.QuietSteps 				= true

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.InfiniteAmmo 				= true
FLAG.NoWeaponDegradation 		= true
FLAG.GasImmune 					= true

FLAG.BloodColor 				= BLOOD_COLOR_MECH

function FLAG.SpeedOverride(ply)
	return 38, 200, 260, 38
end

function FLAG.VisibleRPName(ply)
	return "T20." .. ply:RPName()
end

function FLAG.ModelFunc(ply)
	return {
		head = {
			model = "models/tnb/player/trp/t200.mdl"
		}
	}
end

if CLIENT then
	local points = {
		Vector(-1.9, 14.2, 0),
		Vector(-2, 13.8, 0.15),
		Vector(-2, 13.8, -0.15)
	}

	local mat = Material("sprites/light_glow02_add")
	local color = Color(0, 161, 255)

	function FLAG.PostDrawTranslucentRenderables(ply, depth, skybox)
		if not ply:Alive() then
			return
		end

		local bone = ply:LookupBone("Antlion_Guard.body")

		if bone then
			local matrix = ply:GetBoneMatrix(bone)

			if not matrix then
				return
			end

			render.SetMaterial(mat)

			for _, v in pairs(points) do
				local pos = LocalToWorld(v, angle_zero, matrix:GetTranslation(), matrix:GetAngles())

				render.DrawSprite(pos, 1, 1, color)
			end
		end
	end
end
