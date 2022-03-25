function EFFECT:Init( data )
	local origin = data:GetOrigin()

	if GAMEMODE.Emitter2D then
		for i = 0, 250 do
			local d = math.Rand(0, 360)
			local x = math.cos(d)
			local y = math.sin(d)
			local v = Vector(math.Rand(0, 1000) * x, math.Rand(0, 1000) * y, math.Rand(-500, 500))

			local p = GAMEMODE.Emitter2D:Add("particle/particle_smokegrenade", origin)
			p:SetRoll(math.Rand(0, 360))
			p:SetRollDelta(math.Rand(-0.5, 0.5))
			p:SetDieTime(30 + math.Rand(-5, 5))
			p:SetStartAlpha(255)
			p:SetEndAlpha(0)
			p:SetStartSize(math.Rand(50, 100))
			p:SetEndSize(math.random(100, 200))
			p:SetColor(255, 233, 174)
			p:SetVelocity(v)
			p:SetAirResistance(math.Rand(100, 300))
			p:SetGravity(Vector(math.Rand(-100, 100), math.Rand(-100, 100), -25))
			p:SetCollide(true)
			p:SetBounce(1)
		end
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
