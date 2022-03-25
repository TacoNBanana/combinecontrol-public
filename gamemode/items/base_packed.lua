ITEM = class.Create("base_item")
DEFINE_BASECLASS("base_item")

ITEM.Name 			= "base_packed"

ITEM.ItemClass 		= ""
ITEM.Amount 		= 1

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	table.insert(tab, {
		Name = "Unpack",
		Func = function(item, user)
			if SERVER then
				user:GiveItem(item.ItemClass, item.Amount)

				GAMEMODE:DeleteItem(item)
			end
		end
	})

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end