ITEM = class.Create("base_packed")

ITEM.Name 				= "Packed Assault Rifle Ammunition x120"
ITEM.Description 		= "A sealed carton of assault rifle ammo. Contains 120 rounds."

ITEM.Model				= Model("models/Items/BoxSRounds.mdl")

ITEM.Weight 			= 4 -- Going with 1 weight per 'standard' load, so 120 / 30 = 4 weight

ITEM.ItemClass 			= "ammo_rifle"
ITEM.Amount 			= 120