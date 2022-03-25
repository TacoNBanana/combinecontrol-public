for k in pairs(GAMEMODE.ItemClasses) do
	local scrap = GAMEMODE:GetDefaultItemKey(k, "ScrapItem")

	if scrap and scrap != true then
		GAMEMODE:AddCraftingRecipe({
			Category = "Recycling",
			Visibility = CRAFTVIS_ALLINGREDIENTS,
			Ingredients = {k},
			Result = {scrap}
		})
	end
end

GAMEMODE:AddCraftingRecipe({
	Category = "Recycling",
	Visibility = CRAFTVIS_ALLINGREDIENTS,
	Tool = "junk_toolbox",
	Ingredients = {"junk_tv"},
	Result = {
		"junk_metal:2",
		"junk_capacitors:2",
		"junk_wires:2",
		"junk_pcb",
		"junk_transmitter"
	}
})

GAMEMODE:AddCraftingRecipe({
	Category = "Recycling",
	Visibility = CRAFTVIS_ALLINGREDIENTS,
	Tool = "junk_toolbox",
	Ingredients = {"junk_microwave"},
	Result = {
		"junk_metal:2",
		"junk_psu",
		"junk_wires:2",
		"junk_pcb"
	}
})
