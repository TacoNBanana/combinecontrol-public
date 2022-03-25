AddCSLuaFile()

ENT.Base 	= "cc_grenade_frag"

ENT.Model 	= Model("models/weapons/w_eq_smokegrenade_thrown.mdl")

function ENT:Explode(tr)
	if tr.Fraction ~= 1.0 then
		self:SetPos(tr.HitPos + tr.Normal * 0.6)
	end

	local ed = EffectData()
		ed:SetOrigin(self:GetPos() + Vector(0, 0, 1))
	util.Effect("cc_e_smokegrenade", ed)

	self:EmitSound(Sound("weapons/smokegrenade/sg_explode.wav"))
	self:Fire("Kill", "", 5)
end