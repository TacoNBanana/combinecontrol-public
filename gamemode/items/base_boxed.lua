ITEM = class.Create("base_item")
DEFINE_BASECLASS("base_item")

ITEM.Name 			= "base_boxed"

ITEM.Model 			= Model("models/props_junk/cardboard_box004a.mdl")

ITEM.ItemClass 		= ""
ITEM.Amount 		= 0

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	table.insert(tab, {
		Name = "Open",
		Func = function(item, user)
			if SERVER then
				ply:GiveItem(self:GetProperty("ItemClass"), self:GetProperty("Amount"))

				GAMEMODE:DeleteItem(self)
			end
		end
	})

	return tab
end
