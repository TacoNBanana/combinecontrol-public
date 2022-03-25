net.Receive("nLoadCharacter", function(len)
	hook.Run("CC.SH.LoadCharacter", LocalPlayer())

	GAMEMODE.LastLanguage = nil
end)

hook.Add("OnPlayerScaleDataChanged", "CL.Player.PlayerScale", function(ply, data)
	if not IsValid(ply) then
		return
	end

	local scale = data[1]
	local min = data[2]
	local max = data[3]

	if not scale or not min or not max then
		return
	end

	ply:SetViewOffset(Vector(0, 0, max.z * GAMEMODE.ViewOffset) * scale)
	ply:SetViewOffsetDucked(Vector(0, 0, max.z * GAMEMODE.ViewOffsetCrouched) * scale)

	local mat = Matrix()
	mat:Scale(Vector(scale, scale, scale))
	ply:EnableMatrix("RenderMultiply", mat)

	ply:SetHull(min * scale, max * scale)
	ply:SetHullDuck(min * scale, Vector(max.x, max.y, max.z * GAMEMODE.HullOffsetDucked) * scale)

	ply:SetRenderBounds(min * scale, max * scale)
end)