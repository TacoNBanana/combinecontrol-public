AddCSLuaFile()
DEFINE_BASECLASS("cc_zone")

ENT.Base 			= "cc_zone"

ENT.PrintName 		= "Toxic zone"
ENT.Category 		= "CombineControl - Zones"

ENT.Spawnable 		= true
ENT.AdminSpawnable 	= true

ENT.Color 			= Color(0, 127, 31)

function ENT:Enter(ply, transition)
	if CLIENT and ply == LocalPlayer() then
		if not transition then -- Don't reset fog timer if transitioning from another cloud
			ply.FogStart = CurTime()
		end

		hook.Add("SetupWorldFog", self, function()
			local time = CurTime() - ply.FogStart
			local frac = math.Clamp(time * 0.5, 0, 1)

			render.FogMode(MATERIAL_FOG_LINEAR)
			render.FogStart(-750)
			render.FogEnd(500)
			render.FogMaxDensity(frac)
			render.FogColor(self.Color.r * 0.2, self.Color.g * 0.2, self.Color.b * 0.2)

			return true
		end)
	end

	if SERVER and not transition then
		local immunity = ply:IsGasImmune()

		if immunity == true then
			ply:SendChat(nil, "WARNING", "There's some kind of gas lingering in the air.")
		elseif isnumber(immunity) then
			ply:SendChat(nil, "WARNING", "There's some kind of gas lingering in the air. You shouldn't stick around for long.")
		else
			ply:SendChat(nil, "WARNING", "There's something in the air that's making your eyes water and your lungs burn!")
		end
	end
end

function ENT:Exit(ply, transition)
	if CLIENT and ply == LocalPlayer() then
		hook.Remove("SetupWorldFog", self) -- Always remove entry fog hook, replaced by new zone if transitioning

		if not transition then -- Only setup exit fog if we're not transitioning for good
			ply.FogEnd = CurTime() + math.min(2, CurTime() - ply.FogStart)

			hook.Add("SetupWorldFog", self, function()
				local time = ply.FogEnd - CurTime()
				local frac = math.Clamp(time * 0.5, 0, 1)

				if frac == 0 then
					hook.Remove("SetupWorldFog", self)
				end

				render.FogMode(MATERIAL_FOG_LINEAR)
				render.FogStart(-750)
				render.FogEnd(500)
				render.FogMaxDensity(frac)
				render.FogColor(self.Color.r * 0.2, self.Color.g * 0.2, self.Color.b * 0.2)

				return true
			end)
		end
	end

	if SERVER and not transition then
		if ply:IsGasImmune() == true then
			ply:SendChat(nil, "WARNING", "The air seems clear here.")
		else
			ply:SendChat(nil, "WARNING", "Relief washes over you as you take a deep breath of fresh air. You should be fine now.")
		end
	end
end

if SERVER then
	function ENT:Think()
		if not self:IsReady() then
			return
		end

		for k in pairs(self.Active) do
			if not IsValid(k) then
				continue
			end

			local immunity = k:IsGasImmune()

			if immunity == true then
				continue
			end

			k.NextGas = k.NextGas or CurTime()

			if k.NextGas > CurTime() then
				continue
			end

			local dmg = DamageInfo()

			dmg:SetAttacker(self)
			dmg:SetDamage(immunity == false and 5 or 1)
			dmg:SetDamageType(DMG_DIRECT)
			dmg:SetInflictor(k)

			local punch = k:GetViewPunchAngles()

			k:TakeDamageInfo(dmg)

			if immunity != false then
				k:SetViewPunchAngles(punch)
			end

			k.NextGas = immunity == false and CurTime() + 1 or CurTime() + immunity / 100
		end
	end
end
