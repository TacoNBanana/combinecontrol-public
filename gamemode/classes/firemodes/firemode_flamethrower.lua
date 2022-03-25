FIREMODE = class.Create("firemode_semi")

FIREMODE.Name 			= "Flamethrower"

FIREMODE.Automatic 		= true

FIREMODE.AmmoCaliber 	= "fuel"

function FIREMODE:CanReload(weapon)
	return false
end

function FIREMODE:CanFire(weapon)
	if weapon:ShouldLower() then
		return false
	end

	return true
end

function FIREMODE:Fire(weapon)
	local ply = weapon.Owner
	local delay = weapon.FireDelay

	if not weapon:GetIsFiring() then
		weapon:SetIsFiring(true)
		weapon:StartFiring()

		if vFireInstalled then
			local effectdata = EffectData()
			effectdata:SetAttachment(1)
			effectdata:SetEntity(weapon)

			util.Effect("cc_e_flamethrower_vfire", effectdata, true, true)
		end
	end

	local trace = util.TraceLine({
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + (ply:EyeAngles():Forward() * 400),
		filter = ply,
	})

	if vFireInstalled then
		if not SERVER then
			return
		end

		local forwardBoost = math.Rand(20, 40)
		local frac = ply:GetEyeTrace().Fraction

		if frac < 0.001245 then
			forwardBoost = 1
		end

		local forward = ply:EyeAngles():Forward()
		local pos = ply:GetShootPos() + forward * forwardBoost
		local vel = forward * math.Rand(900, 1000)

		CreateVFireBall(math.Rand(4, 8) * 2.15, 20, pos, vel, ply)
	else
		if IsFirstTimePredicted() then
			local ed = EffectData()

			ed:SetEntity(weapon)
			ed:SetAttachment(1)
			ed:SetAngles(ply:EyeAngles())
			ed:SetMagnitude(5)

			util.Effect("cc_e_flamethrower", ed)
		end

		if SERVER then
			for _, ent in pairs(ents.FindInSphere(trace.HitPos, 16)) do
				if IsValid(ent) and IsValid(ent:GetPhysicsObject()) and ent != ply then
					local dmg = DamageInfo()

					dmg:SetAttacker(ply)
					dmg:SetInflictor(weapon)
					dmg:SetDamageType(DMG_BURN)
					dmg:SetDamage(1)

					ent:TakeDamageInfo(dmg)
					ent:Ignite(ent:IsPlayer() and 12 or 60)
				end
			end
		end
	end

	weapon:SetNextPrimaryFire(CurTime() + delay)
end

function FIREMODE:Think(weapon)
	local ply = weapon.Owner

	if weapon:GetIsFiring() and (weapon:ShouldLower() or not ply:KeyDown(IN_ATTACK)) then
		weapon:SetIsFiring(false)
		weapon:StopFiring()
	end
end

function FIREMODE:UseCrosshair(weapon)
	return false
end