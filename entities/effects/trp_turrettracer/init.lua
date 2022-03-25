EFFECT.Mat = Material("effects/spark")

function EFFECT:Init(data)
	self.EndPos = data:GetOrigin()
	self.StartPos = data:GetStart()

	if not self.StartPos then
		return
	end

	self:SetRenderBoundsWS(self.StartPos, self.EndPos)

	self.Dist = self.StartPos:Distance(self.EndPos)
	self.Time = math.min(1, self.Dist / 10000)
	self.Length = math.Rand(128, 256)

	self.Fraction = self.Length / self.Dist

	-- Die when it reaches its target
	self.DieTime = CurTime() + self.Time
end

function EFFECT:Think()
	if not self.Dist then
		return false
	end

	return CurTime() <= self.DieTime
end

function EFFECT:Render()
	local delta = (self.DieTime - CurTime()) / self.Time
	delta = math.Clamp(delta, 0, 1)

	render.SetMaterial(self.Mat)

	local startpos = LerpVector(delta, self.EndPos, self.StartPos)
	local endpos = LerpVector(math.Clamp(delta + self.Fraction, 0, 1), self.EndPos, self.StartPos)

	render.DrawBeam(startpos, endpos, 32, 1, 0, Color(255, 255, 255))
end
