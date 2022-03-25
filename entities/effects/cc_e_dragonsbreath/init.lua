function EFFECT:Init(data)

	self.StartPos 	= data:GetStart()
	self.EndPos 	= data:GetOrigin()
	self.Magnitude	= data:GetMagnitude()
	self.Scale		= data:GetScale()
	self.Dir		= self.StartPos - self.EndPos
	self.Normal		= self.Dir:GetNormalized()
	
	self:SetRenderBoundsWS( self.StartPos, self.EndPos )
	self.DieTime = math.Rand( 1, 2 )
	
	local Emitter = ParticleEmitter( self.StartPos )
	for i=0,self.Magnitude do
		local flame = Emitter:Add("particles/flamelet"..math.random(1,5), self.StartPos)
		
		if flame then
		
			flame:SetVelocity(-self.Normal * math.Rand(2000, 3000) + VectorRand() * 25 * self.Scale)
			flame:SetAngles(self.Normal:Angle())
			flame:SetLifeTime(0)
			flame:SetDieTime(math.Rand(0.5, 1)^2)
			flame:SetStartAlpha(255)
			flame:SetEndAlpha(0)
			flame:SetStartSize(4)
			flame:SetEndSize(1)
			flame:SetAirResistance(100)
			flame:SetColor(255, 255, 255)
			
			-- this makes the little sparks spin a bit
			flame:SetRoll( math.Rand(0, 360) )
			flame:SetRollDelta( math.Rand( -10, 10 ) )
			
		end
		
	end
	
	for i=0,self.Magnitude*5 do 
		
		local spark = Emitter:Add("effects/spark", self.StartPos)
		if spark then
			-- gives it a more circular shape by adding some randomness, more VectorRand() means more circular, more scale means wider
			local velNoise = VectorRand() * 20 * self.Scale + VectorRand() * 20 * self.Scale + VectorRand() * 20 * self.Scale
			spark:SetVelocity(-self.Normal * math.Rand(2000, 3000) + velNoise)
			spark:SetAngles(self.Normal:Angle())
			spark:SetLifeTime(0)
			spark:SetDieTime(math.Rand(0.5, 1)^2)
			spark:SetStartAlpha(255)
			spark:SetEndAlpha(0)
			spark:SetStartSize(2)
			spark:SetEndSize(1)
			spark:SetAirResistance(100)
			spark:SetColor(255, 255, 255)
			
			-- this makes the little sparks spin a bit
			spark:SetRoll( math.Rand(0, 360) )
			spark:SetRollDelta( math.Rand( -10, 10 ) )
			
			-- bounce off of walls sorta slowly
			spark:SetCollide(true)
			spark:SetBounce(0.1)
			
		end
		
	end
	
	Emitter:Finish()
	
end

function EFFECT:Think()
	return false
end
