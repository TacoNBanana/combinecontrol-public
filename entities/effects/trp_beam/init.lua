EFFECT.Mat = Material("models/effects/splodearc_sheet")

function EFFECT:Init(data)
	self.Pos = data:GetStart()
	self.Ent = data:GetEntity()
	self.Attachment = data:GetAttachment()

	self.Start, self.Target = self:GetStartPos(self.Pos, self.Ent, self.Attachment)
	self.End = data:GetOrigin()

	local start = self.Start

	if not isvector(start) then
		if not IsValid(self.Target) then
			return
		end

		start = self.Target:GetPos(start)
	end

	self.Normal = (start - self.End):Angle():Forward()

	self:SetRenderBoundsWS(start, self.End)

	self.DieTime = CurTime() + 0.1

	self.Color = Color(97, 245, 194)

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
	dynlight.Pos = start
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
				return index, vm
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
			return muzzle, target
		end
	end

	return pos
end

function EFFECT:Think()
	if self.DieTime and CurTime() > self.DieTime then
		return false
	end

	return true
end

function EFFECT:Render()
	local pos = self.Start

	if not isvector(pos) then
		if not IsValid(self.Target) then
			return
		end

		pos = self.Target:GetAttachment(self.Start).Pos
	end

	render.SetMaterial(self.Mat)
	render.DrawBeam(pos, self.End, 10, 0, 0, Color(255, 255, 255))
end