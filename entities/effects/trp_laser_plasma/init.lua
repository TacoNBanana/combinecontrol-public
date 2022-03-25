EFFECT.Mat = Material("trails/plasma")

function EFFECT:Init(data)
	self.Pos = data:GetStart()
	self.Ent = data:GetEntity()
	self.Attachment = data:GetAttachment()

	self.Start = self:GetStartPos(self.Pos, self.Ent, self.Attachment)
	self.End = data:GetOrigin()

	self.Normal = (self.Start - self.End):Angle():Forward()

	if os.date("!%d-%m") == "01-04" then
		local time = (CurTime() - self.Ent:GetCreationTime()) * 100

		self.Color = HSVToColor(time % 360, 1, 1)
	else
		self.Color = self.Ent.LaserColor or Color(150, 100, 255)
	end

	self:SetRenderBoundsWS(self.Start, self.End)

	self.Alpha = 150

	local dynlight = DynamicLight(0)
	dynlight.Pos = self.End + self.Normal * 10
	dynlight.Size = 100
	dynlight.Brightness = 1
	dynlight.Decay = 3000
	dynlight.R = self.Color.r
	dynlight.G = self.Color.g
	dynlight.B = self.Color.b
	dynlight.DieTime = CurTime() + 0.1

	dynlight = DynamicLight(0)
	dynlight.Pos = self.Start
	dynlight.Size = 100
	dynlight.Brightness = 1
	dynlight.Decay = 3000
	dynlight.R = self.Color.r
	dynlight.G = self.Color.g
	dynlight.B = self.Color.b
	dynlight.DieTime = CurTime() + 0.1

	self.Ent.SwitchSide = not self.Ent.SwitchSide
end

function EFFECT:GetStartPos(pos, ent, index)
	if not IsValid(ent) then
		return pos
	end

	if not ent:IsWeapon() then
		return pos
	end

	if ent:IsCarriedByLocalPlayer() and not LocalPlayer():ShouldDrawLocalPlayer() then
		local vm = LocalPlayer():GetViewModel()

		if IsValid(vm) then
			local att = vm:GetAttachment(index)

			if att then
				return att.Pos
			end
		end
	else
		local mdl = ent:GetModel()

		local target
		local muzzle

		if mdl == "" then
			target = ent.Owner

			if ent.AttachmentOverride then
				muzzle = target:LookupAttachment(ent.AttachmentOverride)
			else
				muzzle = target:LookupAttachment("muzzle")

				if muzzle == 0 then
					muzzle = target:LookupAttachment(ent.SwitchSide and "muzzle_left" or "muzzle_right")
				end
			end
		else
			target = ent
			muzzle = target:LookupAttachment("muzzle")
		end

		local att = target:GetAttachment(muzzle)

		if att then
			return att.Pos
		end
	end

	return pos
end

function EFFECT:Think()
	self.Alpha = self.Alpha - FrameTime() * 2048

	if self.Alpha < 0 then
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
	render.DrawBeam(self.Start, self.End, 16, texcoord, texcoord + length / 128, self.Color)
end