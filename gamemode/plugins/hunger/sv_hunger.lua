hook.Add("CC.SV.SpeedThink", "SV.Hunger.SpeedThink", function(ply)
	if not GAMEMODE.UseHunger then
		return
	end

	local r = ply:GetRunSpeed()
	local j = ply:GetJumpPower()

	r = r * (1 - (ply:Hunger() / 100) / 4)
	j = j * (1 - (ply:Hunger() / 100) / 4)

	ply:SetRunSpeed(r)
	ply:SetJumpPower(j)
end)

hook.Add("CC.SV.PlayerThink", "SV.Hunger.PlayerThink", function(ply)
	if not GAMEMODE.UseHunger then
		return
	end

	if not ply.HungerUpdate then
		ply.HungerUpdate = CurTime()
	end

	if CurTime() >= ply.HungerUpdate and ply:CharID() != -1 and ply:GetVelocity():Length2D() > 5 and not ply:IsEFlagSet(EFL_NOCLIP_ACTIVE) then
		ply.HungerUpdate = CurTime() + 720

		ply:SetHunger(math.Clamp(ply:Hunger() + 1, 0, 100))
		ply:UpdateCharacterField("Hunger", ply:Hunger())
	end
end)

hook.Add("CC.SV.InitSQL", "SV.Hunger.InitSQL", function()
	GAMEMODE:AddSQLColumn("chars", "Hunger", "FLOAT", 0)
end)

hook.Add("CC.SV.LoadCharacterData", "SV.Hunger.LoadCharacterData", function(ply, data)
	ply:SetHunger(tonumber(data.Hunger))
end)
