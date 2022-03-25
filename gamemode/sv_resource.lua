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
