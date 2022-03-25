FLAG.PrintName 					= "T-20"
FLAG.NameFormat 				= "T20.%s"

FLAG.Health 					= 200
FLAG.ArmorValue 				= 30

FLAG.Loadout 					= {"trp_t20", "trp_t20_repair", "trp_t20_light"}

FLAG.Scale 						= 0.2

FLAG.QuietSteps 				= true

function FLAG.ModelFunc(ply)
	return {
		head = {
			model = "models/tnb/player/trp/t200.mdl"
		}
	}
end

function FLAG.SpeedOverride(ply)
	return 38, 200, 260, 38
end

if CLIENT then
	local points = {
		Vector(-1.8, 14.2, 0),
		Vector(-2, 13.8, 0.15),
		Vector(-2, 13.8, -0.15)
	}

	local mat = Material("sprites/light_glow02_add")
	local color = Color(255, 0, 0)

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
