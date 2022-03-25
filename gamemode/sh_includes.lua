function GetFileRealm(filename)
	local pre = string.sub(filename, 1, 3)
	local sh = pre == "sh_"
	local cl = pre == "cl_"
	local sv = pre == "sv_" or (not sh and not cl)

	return cl or sh, sv or sh
end

function IncludeFolder(path)
	local files, folders = file.Find(path and (path .. "/*") or "*", "LUA")

	for k, filename in pairs(files) do
		local cl, sv = GetFileRealm(filename)

		if SERVER then
			if cl then
				AddCSLuaFile(path .. "/" .. filename)
			end

			if sv then
				include(path .. "/" .. filename)
			end
		elseif CLIENT and cl then
			include(path .. "/" .. filename)
		end
	end

	for k, folder in pairs(folders) do
		IncludeFolder(path .. "/" .. folder)
	end
end

IncludeFolder(GM.FolderName .. "/gamemode/includes")
IncludeFolder(GM.FolderName .. "/gamemode/plugins")