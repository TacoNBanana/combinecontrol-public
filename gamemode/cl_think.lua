function GM:Think()
	self.BaseClass:Think()

	self:MusicThink()
	self:CreateParticleEmitters()
	self:PMUpdatePrison()
	self:ToggleHolsterThink()
	self:DrugThink()

	self:CharCreateThink()

	if GetConVarNumber("physgun_wheelspeed") > 20 then
		RunConsoleCommand("physgun_wheelspeed", "20")
	end

	if Vector(GetConVar("cl_weaponcolor")) ~= Vector(0.15, 0.81, 0.91) then
		RunConsoleCommand("cl_weaponcolor", "0.15 0.81 0.91")
	end

	hook.Run("CC.SH.Think")
end
