GM.Crafting = {}

-- CanSeeRecipe(self, items, entity) - Return true or false to override default behavior
-- CanCraftRecipe(self, items, entity, amt) - Return true or false to override default behavior
-- OnCraft(self, ply) - Return args override default behavior for handling ingredients and results on true

function GM:AddCraftingRecipe(tab)
	local base = {
		Category 			= "NULL",

		Entity 				= "cc_workbench",
		Tool 				= "",
		Visibility 			= CRAFTVIS_ALWAYS,

		Ingredients 		= {},
		Result 				= "",

		CanSeeRecipe 		= stub,
		CanCraftRecipe 		= stub,
		OnCraft 			= stub
	}

	tab = table.Merge(base, tab)

	table.insert(self.Crafting, tab)
end

local files = file.Find(GM.FolderName .. "/gamemode/crafting/*.lua", "LUA", "namedesc")

if #files > 0 then
	for _, v in pairs(files) do
		AddCSLuaFile(GM.FolderName .. "/gamemode/crafting/" .. v)
		include(GM.FolderName .. "/gamemode/crafting/" .. v)
	end
end

function GM:UnpackRecipe(str)
	local expl = string.Explode(":", str)
	local amt = 1

	if expl[2] then
		amt = tonumber(expl[2])
	end

	return expl[1], amt
end

function GM:HasRecipeItem(items, str, amt)
	amt = amt or 1

	local item, amount = GAMEMODE:UnpackRecipe(str)

	return GAMEMODE:HasItem(items, item, amount * amt)
end

function GM:CanSeeRecipe(items, entity, index)
	local tab = GAMEMODE.Crafting[index]
	local vis = tab.Visibility

	if tab.CanSeeRecipe != stub then
		local res = tab:CanSeeRecipe(items, entity)

		if res != nil then
			return res
		end
	end

	if entity:GetClass() != tab.Entity then
		return false
	end

	if bit.band(vis, CRAFTVIS_ALLINGREDIENTS) == CRAFTVIS_ALLINGREDIENTS then
		for _, v in pairs(tab.Ingredients) do
			if not self:HasRecipeItem(items, v) then
				return false
			end
		end
	end

	if bit.band(vis, CRAFTVIS_TOOLS) == CRAFTVIS_TOOLS and not self:HasRecipeItem(items, tab.Tool) then
		return false
	end

	return true
end

function GM:GetVisibleRecipes(items, entity)
	local tab = {}

	for k in pairs(GAMEMODE.Crafting) do
		if self:CanSeeRecipe(items, entity, k) then
			table.insert(tab, k)
		end
	end

	return tab
end

function GM:CanCraftRecipe(items, entity, index, amt)
	amt = amt or 1

	if amt < 1 then
		return false, "Invalid amount"
	end

	if not self:CanSeeRecipe(items, entity, index) then
		return false, "Invalid recipe"
	end

	local tab = GAMEMODE.Crafting[index]

	if tab.CanCraftRecipe != stub then
		local res, msg = tab:CanCraftRecipe(items, entity, amt)

		if res != nil then
			return res, msg
		end
	end

	if #tab.Tool > 0 and not self:HasRecipeItem(items, tab.Tool) then
		return false, "Missing tool"
	end

	for _, v in pairs(tab.Ingredients) do
		local item, amount = GAMEMODE:UnpackRecipe(v)

		if not self:HasRecipeItem(items, item, amount * amt) then
			return false, "Missing ingredients"
		end
	end

	return true
end