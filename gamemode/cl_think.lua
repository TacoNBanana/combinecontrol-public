function GM:Think()
	self.BaseClass:Think()

	self:MusicThink()
	self:CreateParticleEmitters()
	self:ToggleHolsterThink()
	self:DrugThink()

	self:CharCreateThink()

	if GetConVarNumber("physgun_wheelspeed") > 20 then
		RunConsoleCommand("physgun_wheelspeed", "20")
	end

	for _, v in pairs(player.GetAll()) do
		hook.Run("PlayerThink", v)
	end

	hook.Run("CC.SH.Think")
end
