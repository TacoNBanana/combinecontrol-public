function EFFECT:Init(data)
	self.Player = data:GetEntity()

	for _, v in pairs(self.Player:GetChildren()) do
		if v:GetClass() != "cc_attachment" or v:GetModelSlot() != "exo" then
			continue
		end

		self.Entity = v

		break
	end

	self:SetParent(self.Player)

	local b = self.Player:BoundingRadius()

	self:SetRenderBounds(vector_origin, vector_origin, Vector(b, b, b))

	self.NextSmoke = CurTime() + 0.01
end

local attachments = {1, 2}

function EFFECT:Think()
	if not IsValid(self.Entity) or not self.Player:JumpPackActive() then
		return false
	end

	self:SetRenderOrigin(self.Player:EyePos())

	return true
end

local beamMat = Material("effects/strider_muzzle")

function EFFECT:Render()
	render.SetMaterial(beamMat)

	for _, v in pairs(attachments) do
		local data = self.Entity:GetAttachment(v)

		local scroll = CurTime() * -20
		local forward = data.Ang:Forward()
		local width = 8

		render.StartBeam(3)
			render.AddBeam(data.Pos, width, scroll, Color(0, 255, 255, 255))
			render.AddBeam(data.Pos + forward * 8, width, scroll + 0.01, Color(255, 255, 255, 255))
			render.AddBeam(data.Pos + forward * 16, width, scroll + 0.02, Color(0, 255, 255, 0))
		render.EndBeam()
	end
end
