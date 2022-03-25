AddCSLuaFile()

ENT.Base 	= "cc_grenade_frag"

ENT.Model 	= Model("models/weapons/w_eq_smokegrenade_thrown.mdl")

ENT.Duration 			= 32
ENT.Range 				= 512

function ENT:Explode(tr)
	if tr.Fraction ~= 1.0 then
		self:SetPos(tr.HitPos + tr.Normal)
	end

	local ed = EffectData()
		ed:SetOrigin(self:GetPos() + Vector(0, 0, 1))
	util.Effect("cc_e_teargas", ed)

	self:EmitSound(Sound("weapons/smokegrenade/sg_explode.wav"))

	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)

	self:SetColor(Color(0, 0, 0, 0))
	self:SetRenderMode(RENDERMODE_TRANSALPHA)

	self.ExplodeTime = CurTime()

	self.Think = function()
		if CLIENT then
			return
		end

		if CurTime() > self.ExplodeTime + self.Duration then
			self:Remove()

			return
		end

		for _, v in pairs(player.GetAll()) do
			if self:GetPos():DistToSqr(v:GetPos()) > self.Range^2 then
				continue
			end

			if v:IsGasImmune() then
				continue
			end

			local trace = util.TraceLine({
				start = self:GetPos(),
				endpos = v:WorldSpaceCenter(),
				mask = MASK_SOLID_BRUSHONLY
			})

			if trace.Fraction == 1 then
				local val = v:Consciousness()

				if val > 25 then
					v:TakeCDamage(10)
				end
			end
		end

		self:NextThink(CurTime() + 0.5)

		return true
	end
end