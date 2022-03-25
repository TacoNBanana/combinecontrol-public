AddCSLuaFile()

ENT.Base 		= "cc_m203"

ENT.SmokeColor 	= Vector(135, 135, 135)

if SERVER then
	function ENT:OnHit(data)
		local ed = EffectData()
			ed:SetOrigin(self:WorldSpaceCenter())
			ed:SetStart(self.SmokeColor)
			ed:SetEntity(self)
		util.Effect("cc_e_smokegrenade", ed)

		self:EmitSound(Sound("weapons/smokegrenade/sg_explode.wav"))

		self.Think = function() end
		SafeRemoveEntityDelayed(self, math.random(50, 90))
	end
end
