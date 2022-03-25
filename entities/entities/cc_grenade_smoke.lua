AddCSLuaFile()

ENT.Base 	= "cc_grenade_frag"
ENT.Model 	= Model("models/weapons/w_eq_smokegrenade.mdl")

function ENT:Explode()
	local ed = EffectData()
		ed:SetOrigin(self:WorldSpaceCenter())
		ed:SetStart(self.SmokeColor)
		ed:SetEntity(self)
	util.Effect("cc_e_smokegrenade", ed)

	self:EmitSound(Sound("weapons/smokegrenade/sg_explode.wav"))
	SafeRemoveEntityDelayed(self, math.random(50, 90))
end