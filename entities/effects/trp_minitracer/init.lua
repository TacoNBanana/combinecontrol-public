EFFECT.Mat = Material("effects/spark")

function EFFECT:Init(data)
	self.EndPos = data:GetOrigin()
	self.Ent = data:GetEntity()
	self.StartPos = self:GetStartPos(self.EndPos, self.Ent, data:GetAttachment())

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

	return CurTime() <= self.DieTime
end

function EFFECT:Render()
	local delta = (self.DieTime - CurTime()) / self.Time
	delta = math.Clamp(delta, 0, 1)

	render.SetMaterial(self.Mat)

	local startpos = LerpVector(delta, self.EndPos, self.StartPos)
	local endpos = LerpVector(math.Clamp(delta + self.Fraction, 0, 1), self.EndPos, self.StartPos)

	render.DrawBeam(startpos, endpos, 6, 1, 0, Color(255, 255, 255))
end