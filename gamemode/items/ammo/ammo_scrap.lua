ITEM = class.Create("base_stacking")

--tekka placeholder for cheap lowest tier recycled ammo

ITEM.Name 				= "Scrap Rounds"
ITEM.Description 		= "Caseless pistol/SMG ammo type that can be forged in a crude home press. Typically inaccurate, weak and unreliable. Can be forged from scrap metal. 600 rounds max carry."

ITEM.Model				= Model("models/Items/BoxSRounds.mdl") --needs its own model

ITEM.MaxStack			= 600
ITEM.Weight 			= 0

--ITEM.IsAmmo			= true (Defines that a player can buy or sell large amounts by entering the amount in a box
--ITEM.Price			= 10 (per bullet)
--ITEM.Resell			= 1 (per bullet also)

--     these will be multiplied, not like in SRP where each box of ammo came default amounts like 30 rounds of 7.62 etc
--		by default it will just sell 1 round unless specified

--		the re-sell value should probably be displayed so that traders can give an estimate of cost to the person trying to trade with them