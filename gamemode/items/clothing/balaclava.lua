ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Balaclava"
ITEM.Description 			= "A black full-face mask coupled with a pair of opaque goggles."

ITEM.Model					= Model("models/tnb/items/trp/headgear/mask2.mdl")

ITEM.Weight 				= 0.2

ITEM.Slots 					= {EQUIPMENT_EYES}

if SERVER then
	function ITEM:PostGetModelData(ply, data)
		if not data.head.replaced then
			data.head.model = string.format("models/tnb/heads/trp/%s_balaclava.mdl", ply:Gender(data.head.model))
		end
	end
end
