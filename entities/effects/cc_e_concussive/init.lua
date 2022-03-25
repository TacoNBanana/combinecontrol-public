function EFFECT:Init(data)
	self.Pos = data:GetStart()
	self.Ent = data:GetEntity()
	self.Attachment = data:GetAttachment()

	self.Start = self:GetTracerShootPos(self.Pos, self.Ent, self.Attachment)
	self.End = data:GetOrigin()

	local angle = (self.End - self.Start):Angle()
	local vec = angle:Forward()

	local particle = GAMEMODE.Emitter2D:Add("particle/warp1_warp", self.Start)

	particle:SetVelocity(vec * 600)
	particle:SetDieTime(0.2)
	particle:SetStartSize(1)
	particle:SetEndSize(120)
	particle:SetCollide(true)

	for i = 1, 10 do
		local smoke = GAMEMODE.Emitter2D:Add("particle/particle_smokegrenade", self.Start)
		local dir = (vec + VectorRand() * 0.5):GetNormalized()

		smoke:SetVelocity(dir * 120)
		smoke:SetDieTime(0.4)
		smoke:SetStartSize(1)
		smoke:SetEndSize(15)
		smoke:SetCollide(true)
	end
end


function EFFECT:Think()
	return false
end


function EFFECT:Render()
end