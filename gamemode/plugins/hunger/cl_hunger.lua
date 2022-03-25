hook.Add("CC.CL.DrawHUDBars", "CL.Hunger.DrawHUDBars", function(y, w)
	GAMEMODE.HGDraw = math.Clamp(LocalPlayer():Hunger(), 0, 100)

	if GAMEMODE.UseHunger and GAMEMODE.HGDraw > 0 then
		draw.RoundedBox(0, 20, y, w, 14, Color(30, 30, 30, 200))
		draw.RoundedBox(0, 22, y + 2, (w - 4) * (GAMEMODE.HGDraw / 100), 10, Color(37, 150, 37, 255))
	end
end)