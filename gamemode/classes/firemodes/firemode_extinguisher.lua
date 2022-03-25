FIREMODE = class.Create("firemode_semi")

FIREMODE.Name 			= "Extinguisher"

FIREMODE.Automatic 		= true

FIREMODE.AmmoCaliber 	= "foam"

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

	ply:SetAnimation(PLAYER_ATTACK1)

	if not weapon:GetIsFiring() then
		weapon:SetIsFiring(true)
		weapon:StartFiring()

		weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	end

	if IsFirstTimePredicted() then
		local ed = EffectData()

		ed:SetAttachment(1)
		ed:SetEntity(ply)
		ed:SetOrigin(ply:GetShootPos())
		ed:SetNormal(ply:GetAimVector())
		ed:SetScale(1)

		util.Effect("cc_e_extinguisher", ed)
	end

	if SERVER then
		local trace = util.TraceLine({
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + (ply:EyeAngles():Forward() * 256),
			filter = ply,
		})

		for _, ent in pairs(ents.FindInSphere(trace.HitPos, 80)) do
			if IsValid(ent) then
				if math.Rand(0, 1) > 0.75 then
					local retval = hook.Call("ExtinguisherDoExtinguish", nil, ent)
					if retval == true then
						continue
					end

					if ent:IsOnFire() then
						ent:Extinguish()
					end

					if string.find(ent:GetClass(), "env_fire") then
						ent:Fire("Extinguish")
					end
				end

				if IsValid(ent:GetPhysicsObject()) then
					ent:GetPhysicsObject():ApplyForceOffset(ply:GetAimVector() * 196, trace.HitPos)
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

		weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	end
end

function FIREMODE:UseCrosshair(weapon)
	return false
end