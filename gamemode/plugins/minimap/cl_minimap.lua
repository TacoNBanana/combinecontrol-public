concommand.Add("rp_dev_updateminimap", function(ply)
	if not ply:IsDeveloper() then
		return
	end

	GAMEMODE:SendMinimapData("nSubmitMinimap", "pointcloud_export.png")
end)

net.Receive("nDownloadMinimap", function(len)
	local data = GAMEMODE:ReadMinimapData()

	if data then
		file.Write("combinecontrol/maps/" .. game.GetMap() .. ".png", data)

		GAMEMODE:LoadMinimap()
	end
end)

net.Receive("nUseCachedMinimap", function(len)
	GAMEMODE:LoadMinimap()
end)
