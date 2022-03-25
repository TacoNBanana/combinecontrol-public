EFFECT.Mat = Material("trails/laser")

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

	self.Dist = self.Start:Distance(self.End)
	self.Time = math.min(1, self.Dist / 10000)
	self.Length = math.Rand(128, 160)

	self.Fraction = self.Length / self.Dist

	-- Die when it reaches its target
	self.DieTime = CurTime() + self.Time

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
	if not self.Dist then
		return false
	end

	local delta = (self.DieTime - CurTime()) / self.Time
	delta = math.Clamp(delta, 0, 1)

	local startpos = LerpVector(delta, self.End, self.Start)
	local endpos = LerpVector(math.Clamp(delta + self.Fraction, 0, 1), self.End, self.Start)

	local dynlight = DynamicLight(0)
	dynlight.Pos = startpos
	dynlight.Size = 100
	dynlight.Brightness = 1
	dynlight.Decay = 3000
	dynlight.R = self.Color.r
	dynlight.G = self.Color.g
	dynlight.B = self.Color.b
	dynlight.DieTime = CurTime() + 0.1

	dynlight = DynamicLight(0)
	dynlight.Pos = endpos
	dynlight.Size = 100
	dynlight.Brightness = 1
	dynlight.Decay = 3000
	dynlight.R = self.Color.r
	dynlight.G = self.Color.g
	dynlight.B = self.Color.b
	dynlight.DieTime = CurTime() + 0.1

	return CurTime() <= self.DieTime
end

function EFFECT:Render()
	local delta = (self.DieTime - CurTime()) / self.Time
	delta = math.Clamp(delta, 0, 1)

	render.SetMaterial(self.Mat)

	local startpos = LerpVector(delta, self.End, self.Start)
	local endpos = LerpVector(math.Clamp(delta + self.Fraction, 0, 1), self.End, self.Start)

	local length = (startpos - endpos):Length()
	local texcoord = math.Rand(0, 1)

	render.DrawBeam(startpos, endpos, 8, texcoord, texcoord + length / 128, self.Color)
end