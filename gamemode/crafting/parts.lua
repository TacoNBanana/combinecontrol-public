hook.Add("OnGamemodeLoaded", "SH.Parts.OnGamemodeLoaded", function()
	for k in pairs(GAMEMODE.ItemClasses) do
		local scrap = GAMEMODE:GetDefaultItemKey(k, "ScrapItem")

		if scrap then
			GAMEMODE:AddCraftingRecipe({
				Category = "Recycling",
				Visibility = CRAFTVIS_ALLINGREDIENTS,
				Ingredients = {k},
				Result = scrap
			})
		end
	end
end)