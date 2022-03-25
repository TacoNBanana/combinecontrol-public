function GM:Think()
	for _, v in pairs(player.GetAll()) do
		hook.Run("CC.SV.PlayerThink", v)
	end

	self:SQLThink()
	self:SpawnerThink()
	self:CombineCameraThink()

	hook.Run("CC.SH.Think")
end