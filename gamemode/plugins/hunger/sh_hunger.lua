hook.Add("CC.SH.SetupPlayerAccessors", "SH.Hunger.PlayerAccessors", function()
	GAMEMODE:RegisterPlayerAccessor("Hunger", false, "Float", 0)
end)