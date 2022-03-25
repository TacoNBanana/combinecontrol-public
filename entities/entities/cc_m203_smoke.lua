AddCSLuaFile()

ENT.Base 				= "cc_m203"

if SERVER then
	function ENT:OnHit(data)
		local ed = EffectData()
		ed:SetOrigin(self:GetPos() + Vector(0, 0, 1))
		util.Effect("cc_e_smokegrenade", ed)

		self:EmitSound(Sound("weapons/smokegrenade/sg_explode.wav"))
	end
end