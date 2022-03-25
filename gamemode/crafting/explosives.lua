GAMEMODE:AddCraftingRecipe({
	Category = "Explosives",
	Visibility = CRAFTVIS_TOOLS,
	Tool = "crafting_explosives",
	Ingredients = {
		"junk_explosives",
		"junk_alarmclock",
		"junk_electricaltape",
		"junk_wires"
	},
	Result = {"c4"}
})

GAMEMODE:AddCraftingRecipe({
	Category = "Explosives",
	Visibility = CRAFTVIS_TOOLS,
	Tool = "crafting_explosives",
	Ingredients = {
		"junk_explosives",
		"junk_metal",
		"junk_electricaltape",
		"junk_wires"
	},
	Result = {"mine_improvised:2"}
})

GAMEMODE:AddCraftingRecipe({
	Category = "Explosives",
	Visibility = CRAFTVIS_ALWAYS,
	Ingredients = {
		"junk_explosives",
		"junk_metal:2",
		"junk_ducttape"
	},
	Result = {"grenade_pipebomb:4"}
})

GAMEMODE:AddCraftingRecipe({
	Category = "Explosives",
	Visibility = CRAFTVIS_TOOLS,
	Ingredients = {
		"junk_explosives:2",
		"junk_powerconduit:2",
		"junk_electricaltape",
		"junk_metal:2"
	},
	Result = {"grenade_canister"}
})
