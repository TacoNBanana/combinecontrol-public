net.Receive("nCraftingMenu", function(len)
	local ent = net.ReadEntity()

	CCP.Crafting = vgui.Create("CCCrafting")
	CCP.Crafting:MakePopup()

	CCP.Crafting:SetEntity(ent)
	CCP.Crafting:PopulateCategories()
	CCP.Crafting:PopulateRecipes()
end)
