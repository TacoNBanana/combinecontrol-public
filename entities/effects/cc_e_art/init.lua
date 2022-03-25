function EFFECT:Init(data)
	local position = data:GetOrigin()
	local normal = data:GetNormal()

	for i = 1, 50 do
		local vec = (normal + 1.2 * VectorRand()):GetNormalized()

		local particle = GAMEMODE.Emitter2D:Add("effects/bluespark", position + 126 * vec)
		particle:SetVelocity(600 * -vec)
		particle:SetDieTime(1)
		particle:SetStartSize(math.Rand(3, 4))
		particle:SetEndSize(0)
		particle:SetStartLength(math.Rand(30, 40))
		particle:SetEndLength(0)
		particle:SetAirResistance(1)
		particle:SetColor(255, 255, 255)
		particle:SetCollide(true)
		particle:SetBounce(0.6)
	end

	local particle = GAMEMODE.Emitter2D:Add("sprites/strider_blackball", position)
	particle:SetDieTime(0.1)
	particle:SetStartSize(126)
	particle:SetEndSize(0)
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
end


function EFFECT:Think()
	return false
end


function EFFECT:Render()
end