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

	hook.Run("CC.SH.Think")
end
