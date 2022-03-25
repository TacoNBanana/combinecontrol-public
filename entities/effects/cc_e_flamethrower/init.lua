function EFFECT:Init(data)
	local ent 		= data:GetEntity()

	if not IsValid(ent) then
		return
	end

	local attach 	= data:GetAttachment()
	local magnitude = data:GetMagnitude()
	local dir 		= data:GetAngles():Forward()

	local normal 	= dir:GetNormalized()

	local origin = self:GetStartPos(ent:GetPos(), ent, attach)

	for i = 0, magnitude do
		local fire = GAMEMODE.Emitter2D:Add("particles/flamelet" .. math.random(1,5), origin)

		if fire then
			fire.DieTime = math.Rand(0.5, 1) ^ 2

			fire:SetVelocity(normal * math.Rand(500, 1000) + (VectorRand() * 10) * 2)
			fire:SetAngles(normal:Angle())

			fire:SetLifeTime(0)
			fire:SetDieTime(fire.DieTime)

			fire:SetStartAlpha(255)
			fire:SetEndAlpha(0)

			fire:SetStartSize(0)
			fire:SetEndSize(50)

			fire:SetAirResistance(100)
			fire:SetGravity(Vector(0, 0, 200))
			fire:SetBounce(0.1)

			fire:SetColor(100, 100, 100)
			fire:SetLighting(false)

			fire:SetCollide(true)

			fire:SetRoll(math.Rand(0, 360))
			fire:SetRollDelta(math.Rand(-10, 10))

			fire:SetNextThink(CurTime())
			fire:SetThinkFunction(function(particle)
				local fraction = particle:GetLifeTime() / particle:GetDieTime()
				local size = math.Remap(fraction, 0, 1, particle:GetStartSize(), particle:GetEndSize())
				local smoke = GAMEMODE.Emitter2D:Add("particle/smokesprites_000" .. math.random(1,9), particle:GetPos() + (VectorRand() * size))

				smoke:SetVelocity(particle:GetVelocity() + (VectorRand() * size))

				smoke:SetLifeTime(0)
				smoke:SetDieTime(math.Rand(1, 2) ^ 1.5)

				smoke:SetStartAlpha(20)
				smoke:SetEndAlpha(0)

				smoke:SetStartSize(size)
				smoke:SetEndSize(math.Rand(40, 80))

				smoke:SetAirResistance(220)
				smoke:SetGravity(Vector(math.Rand(-100, 100), math.Rand(-100, 100), math.Rand(400, 500)))
				smoke:SetBounce(0.1)

				smoke:SetColor(0, 0, 0)
				smoke:SetLighting(false)

				smoke:SetCollide(true)

				smoke:SetRollDelta(math.Rand(-1, 1))

				particle:SetNextThink(CurTime() + 0.2)
			end)
		end

		local dlight = DynamicLight(ent:EntIndex())

		if dlight then
			dlight.Pos = origin
			dlight.r = 255
			dlight.g = 127
			dlight.b = 0
			dlight.Brightness = 4
			dlight.Size = 75
			dlight.Decay = 100
			dlight.DieTime = CurTime() + 0.1
			dlight.Style = 1
		end
	end
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
		local tab

		if ent:GetModel() == "" then
			local att = ent.Owner:LookupAttachment("minigun")

			tab = ent.Owner:GetAttachment(att)
		else
			local att = ent:LookupAttachment(index)

			tab = ent:GetAttachment(att)
		end

		if tab then
			return tab.Pos
		end
	end

	return pos
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end