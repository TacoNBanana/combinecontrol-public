ITEM = class.Create("base_stacking")

--tekka placeholder for cheap lowest tier recycled shotgun ammo

ITEM.Name 				= "Scrap Flak Rounds"
ITEM.Description 		= "Compressed scrap metal shards in a recycled shell housing. Commonly fired from crude shotgun style weapons. 100 rounds max carry."

ITEM.Model				= Model("models/Items/BoxSRounds.mdl") --needs its own model

ITEM.MaxStack			= 100
ITEM.Weight 			= 0

--ITEM.IsAmmo			= true (Defines that a player can buy or sell large amounts by entering the amount in a box
--ITEM.Price			= 10 (per bullet)
--ITEM.Resell			= 1 (per bullet also)

--     these will be multiplied, not like in SRP where each box of ammo came default amounts like 30 rounds of 7.62 etc
--		by default it will just sell 1 round unless specified

--		the re-sell value should probably be displayed so that traders can give an estimate of cost to the person trying to trade with them