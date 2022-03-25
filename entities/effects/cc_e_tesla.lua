EFFECT.Mat = Material("sprites/rollermine_shock")
EFFECT.Color = Color(255, 255, 255)

local function translatefov(ent, pos, inverse)
	local worldx = math.tan(LocalPlayer():GetFOV() * (math.pi / 360))
	local viewx = math.tan(ent.ViewModelFOV * (math.pi / 360))

	local factor = Vector(worldx / viewx, worldx / viewx, 0)
	local tmp = pos - EyePos()

	local eye = EyeAngles()
	local transformed = Vector(eye:Right():Dot(tmp), eye:Up():Dot(tmp), eye:Forward():Dot(tmp))

	if inverse then
		transformed.x = transformed.x / factor.x
		transformed.y = transformed.y / factor.y
	else
		transformed.x = transformed.x * factor.x
		transformed.y = transformed.y * factor.y
	end

	local out = (eye:Right() * transformed.x) + (eye:Up() * transformed.y) + (eye:Forward() * transformed.z)

	return EyePos() + out
end

function EFFECT:Init(data)
	self.Pos = data:GetStart()
	self.Ent = data:GetEntity()
	self.Attachment = data:GetAttachment()

	self.Start = self:GetStartPos(self.Pos, self.Ent, self.Attachment)
	self.End = data:GetOrigin()

	self.Normal = (self.Start - self.End):Angle():Forward()

	self:SetRenderBoundsWS(self.Start, self.End)

	self.StartTime = CurTime()
	self.Lifetime = 0.1

	self:GenerateLightning()

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
				return translatefov(ent, att.Pos)
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

function EFFECT:GenerateLightning()
	self.Beams = {{
		Beams = {self.Start, self.End},
		Offshoot = 1
	}}

	local distance = self.Start:Distance(self.End)

	local subdivisions = 4
	local deviation = distance / 15

	for i = 1, subdivisions do
		local rand = deviation / i

		for j = 1, #self.Beams do
			local data = self.Beams[j]
			local new = {}

			table.insert(new, data.Beams[1])

			local offshoot = math.random(1, #data.Beams - 1)

			for k, origin in pairs(data.Beams) do
				if k == #data.Beams then
					break
				end

				local target = data.Beams[k + 1]

				local midpoint = (target + origin) * 0.5
				local direction = target - origin

				local offset = VectorRand(-rand, rand)

				offset.x = 0
				offset:Rotate(direction:Angle())

				local pos = midpoint + offset

				table.insert(new, pos)
				table.insert(new, target)

				if k == offshoot then
					table.insert(self.Beams, {
						Beams = {pos, pos + (direction * 0.4)},
						Offshoot = data.Offshoot + 1
					})
				end
			end

			data.Beams = new
		end
	end
end

function EFFECT:GetAlpha()
	return math.RemapC(CurTime() - self.StartTime, 0, self.Lifetime, 255, 0)
end

function EFFECT:Think()
	if CurTime() - self.StartTime > self.Lifetime then
		return false
	end

	return true
end

function EFFECT:Render()
	local alpha = self:GetAlpha()

	if alpha < 0 then
		return
	end

	render.SetMaterial(self.Mat)

	for _, data in pairs(self.Beams) do
		render.StartBeam(#data.Beams)

		local beamalpha = alpha / (data.Offshoot ^ 2)

		if beamalpha < 1 then
			continue
		end

		self.Color.a = beamalpha

		local previous = nil
		local texture = 0

		for k, v in ipairs(data.Beams) do
			texture = texture + ((previous != nil) and (previous:Distance(v) / 32) or 0)

			if k == #data.Beams then
				self.Color.a = 0
			end

			render.AddBeam(v + VectorRand(), 16 - (data.Offshoot * 2), texture + 1, self.Color)

			previous = v
		end

		render.EndBeam()
	end
end
