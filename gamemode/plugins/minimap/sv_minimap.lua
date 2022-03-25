util.AddNetworkString("nSubmitMinimap")
util.AddNetworkString("nDownloadMinimap")
util.AddNetworkString("nUseCachedMinimap")

GM.MinimapSent = GM.MinimapSent or {}

net.Receive("nDownloadMinimap", function(len, ply)
	if GAMEMODE.MinimapSent[ply] then
		return
	end

	GAMEMODE.MinimapSent[ply] = true

	if net.ReadString() == GAMEMODE.MinimapCRC then
		net.Start("nUseCachedMinimap")
		net.Send(ply)

		return
	end

	GAMEMODE:SendMinimapData("nDownloadMinimap", "combinecontrol/maps/" .. game.GetMap() .. ".png", ply)
end)

net.Receive("nSubmitMinimap", function(len, ply)
	if not ply:IsDeveloper() then
		return
	end

	local data = GAMEMODE:ReadMinimapData()

	if data then
		file.Write("combinecontrol/maps/" .. game.GetMap() .. ".png", data)
		GAMEMODE:LoadMinimap()
	end
end)

hook.Add("OnGamemodeLoaded", "Minimap", function()
	if file.Exists("combinecontrol/maps/" .. game.GetMap() .. ".png", "DATA") then
		GAMEMODE:LoadMinimap()
	end
end)
