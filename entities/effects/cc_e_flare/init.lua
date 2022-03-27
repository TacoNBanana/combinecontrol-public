function EFFECT:Init(data)
	local o = data:GetOrigin()
	local v = data:GetStart()

	self.StartTime = CurTime()
	self.Size = math.random(32, 48)

	if GAMEMODE.Emitter2D then

		local p = GAMEMODE.Emitter2D:Add("effects/yellowflare", o)
		p:SetRoll(math.Rand(0, 360))
		p:SetRollDelta(math.Rand(1, 4))
		p:SetDieTime(20)
		p:SetStartAlpha(60)
		p:SetStartSize(math.random(64, 100))
		p:SetEndSize(math.random(64, 100))
		p:SetColor(255, 0, 0)
		p:SetVelocity(v)
		p:SetAirResistance(50)
		p:SetGravity(Vector(0, 0, -25))
		p:SetCollide(true)
		p:SetBounce(0.2)

		local p = GAMEMODE.Emitter2D:Add("effects/yellowflare", o)
		p:SetRoll(math.Rand(0, 360))
		p:SetRollDelta(math.Rand(1, 4))
		p:SetDieTime(20)
		p:SetStartAlpha(255)
		p:SetStartSize(self.Size)
		p:SetEndSize(self.Size)
		p:SetColor(255, 255, 255)
		p:SetVelocity(v)
		p:SetAirResistance(50)
		p:SetGravity(Vector(0, 0, -25))
		p:SetCollide(true)
		p:SetBounce(0.2)

		local light = DynamicLight(CurTime())
		if light then
			light.pos = p:GetPos()
			light.r = 255
			light.g = math.random(32, 64)
			light.b = math.random(32, 64)
			light.brightness = 4
			light.Decay = 100
			light.Size = 4096
			light.DieTime = CurTime() + 18
			light.Style = 6
		end

		timer.Create("FlareTimer" .. CurTime(), 0.01, 550, function()

			local s = GAMEMODE.Emitter2D:Add("particle/particle_noisesphere", p:GetPos())

			if s then

				s:SetRoll(math.Rand(0, 360))
				s:SetRollDelta(math.Rand(-6, 6))
				s:SetDieTime(1)
				s:SetStartAlpha(math.random(64, 90))
				s:SetStartSize(3)
				s:SetEndSize(24)
				s:SetColor(255, 48, 48)
				s:SetVelocity(Vector(math.random(-16, 16), math.random(-16, 16), math.random(8, 16) + 32))

			end

			if light then
				light.pos = p:GetPos()
			end

		end)

	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
