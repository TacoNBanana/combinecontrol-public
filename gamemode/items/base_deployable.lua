ITEM = class.Create("base_item")
DEFINE_BASECLASS("base_item")

ITEM.Name 			= "base_deployable"

ITEM.Deployable 	= ""
ITEM.DeployableEnt 	= nil

function ITEM:OnRemove(ply)
	if SERVER and IsValid(self.DeployableEnt) then
		self.DeployableEnt:Remove()
	end
end

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	table.insert(tab, {
		Name = "Deploy",
		Func = function(item, user)
			if SERVER then
				if IsValid(self.DeployableEnt) then
					user:SendChat(nil, "ERROR", "Error: This item is already deployed!")

					return
				end

				item:Deploy(user)
			end
		end
	})

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end

if SERVER then
	function ITEM:Deploy(ply)
		if IsValid(self.DeployableEnt) then
			self.DeployableEnt:Remove()
			self.DeployableEnt = nil
		end

		local pos = ply:EyePos()
		local forward = ply:GetAimVector()

		local tr = util.TraceLine({
			start = pos,
			endpos = pos + (forward * 1024),
			filter = ply
		})

		local sent = scripted_ents.GetStored(self:GetProperty("Deployable"))

		if sent then
			sent = sent.t

			local func = scripted_ents.GetMember(self:GetProperty("Deployable"), "SpawnFunction")

			if not func then
				return
			end

			self.DeployableEnt = func(sent, ply, tr, self:GetProperty("Deployable"))
		end
	end
end
