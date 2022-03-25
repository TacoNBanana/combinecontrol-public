EFFECT.Mat = Material("trails/laser")

function EFFECT:Init(data)
	self.End = data:GetOrigin()
	self.Start = data:GetStart()
	self.Ent = data:GetEntity()

	if GAMEMODE:AprilFools() then
		local time = (CurTime() - self.Ent:GetCreationTime()) * 100

		self.Color = HSVToColor(time % 360, 1, 1)
	else
		self.Color = self.Ent.LaserColor or Color(150, 100, 255)
	end

	self:SetRenderBoundsWS(self.Start, self.End)

	self.Alpha = 150
	self.Rendered = false
end

function EFFECT:Think()
	self.Alpha = self.Alpha - FrameTime() * 2048

	if self.Alpha < 0 and self.Rendered then
		return false
	end

	return true
end

function EFFECT:Render()
	if self.Alpha < 1 then
		return
	end

	local length = (self.Start - self.End):Length()
	local texcoord = math.Rand(0, 1)

	render.SetMaterial(self.Mat)

	for i = 1, 5 do
		render.DrawBeam(self.Start, self.End, 32, texcoord, texcoord + length / 128, self.Color)
	end

	self.Rendered = true
end
