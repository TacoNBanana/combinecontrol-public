ITEM = class.Create("base_item")
DEFINE_BASECLASS("base_item")

ITEM.Name 			= "Makeshift Anti-Personnel Mine"
ITEM.Description 	= "A pressure-triggered explosive device constructed from unexploded ordinance."

ITEM.Model 			= Model("models/tnb/items/ied.mdl")

ITEM.Weight 		= 1

local function trace(ply)
	return util.TraceLine({
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + ply:GetAimVector() * 75,
		filter = {ply},
		mask = MASK_SOLID
	})
end

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if trace(ply).Hit then
		table.insert(tab, {
			Delay = 2,
			DelayName = "Deploying...",
			Name = "Deploy mine",
			Func = function()
				if SERVER then
					local tr = trace(ply)

					if not tr.Hit then
						return
					end

					if tr.HitNormal:Dot(Vector(0, 0, 1)) <= 0 then
						ply:SendChat(nil, "ERROR", "Error: Place your mine on the ground!")

						return
					end

					local ang = tr.HitNormal:Angle()

					ang:RotateAroundAxis(ang:Right(), -90)
					ang:RotateAroundAxis(tr.HitNormal, math.random(0, 359))

					local ent = ents.Create("cc_mine_improvised")

					ent:SetPos(tr.HitPos)
					ent:SetAngles(ang)
					ent:Spawn()
					ent:Activate()

					ent:Save()

					GAMEMODE:DeleteItem(self)
				end
			end
		})
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end
