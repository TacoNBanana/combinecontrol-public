local workshopMapResources = GM.WorkshopMaps[game.GetMap()]

if workshopMapResources then
	if istable(workshopMapResources) then
		for _, id in pairs(workshopMapResources) do
			resource.AddWorkshop(id)
		end
	else
		resource.AddWorkshop(workshopMapResources)
	end
else
	resource.AddSingleFile("maps/" .. game.GetMap() .. ".bsp")
end

if GM.WorkshopAddons then
	for k, v in pairs(GM.WorkshopAddons) do
		resource.AddWorkshop(v)
	end
end

if GM.FastDLFolders then
	for k, v in pairs(GM.FastDLFolders) do
		print("==[Adding " .. v .. " to FastDL]==")
		local list = file.Find(v .. "/*", "GAME")

		for _, f in pairs(list) do
			local directory = v .. "/" .. f
			resource.AddSingleFile(directory)
			print("    >Loaded " .. directory)
		end

		print("    >Success!")
	end
end

if GM.FastDLFiles then
	for k, v in pairs(GM.FastDLFiles) do
		print("==[Adding " .. v .. " to FastDL]==")
		resource.AddFile(v)
		print("    >Success!")
	end
end

if game.GetMap() == "dw_01" or game.GetMap() == "dw_02" or game.GetMap() == "dw_03" or game.GetMap() == "dw_04" or game.GetMap() == "dw_05" or game.GetMap() == "dw_06" or game.GetMap() == "dw_07" or game.GetMap() == "dw_08" then
	hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
	hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
	hook.Remove("Think", "SW.Think")
	hook.Remove("HUDPaint", "SW.HUDPaint")
	hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
	hook.Remove("InitPostEntity", "SW.InitPostEntity")
	hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
	hook.Remove("Initialize", "SW.Initialize")
end