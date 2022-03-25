AddCSLuaFile()

ENT.Base 					= "cc_base_ent"
ENT.Type 					= "anim"

function ENT:Initialize()
	self:SetModel(Model("models/Items/ammocrate_smg1.mdl"))

	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:EnableMotion(false)
		end

		self:SetUseType(SIMPLE_USE)
	end
end

function ENT:Use(ply)
	if SERVER then
		if ply:GetCharFlagAttribute("ItemLoadout") then
			if self.Open then
				self.StartOpen = CurTime() - 1
			else
				self:EmitSound("AmmoCrate.Open")
				self:ResetSequence(self:LookupSequence("Open"))
				self.Open = true
				self.StartOpen = CurTime()
			end

			net.Start("nLoadoutCrate")
			net.Send(ply)
		else
			net.Start("nLoadoutCrateNotAllowed")
			net.Send(ply)
		end
	end
end

function ENT:Think()
	if self.Open and self.StartOpen and CurTime() - self.StartOpen > 2 then
		self:EmitSound("AmmoCrate.Close")
		self:ResetSequence(self:LookupSequence("Close"))
		self.Open = false
	end

	self:NextThink(CurTime())
	return true
end

if CLIENT then
	function nLoadoutCrate(len)
		local loadout = LocalPlayer():GetCharFlagAttribute("ItemLoadout")

		if not loadout then
			return
		end

		CCP.LoadoutCrate = vgui.Create("DFrame")
		CCP.LoadoutCrate:SetSize(590, 500)
		CCP.LoadoutCrate:Center()
		CCP.LoadoutCrate:SetTitle("Faction Loadout")
		CCP.LoadoutCrate.lblTitle:SetFont("CombineControl.Window")
		CCP.LoadoutCrate:MakePopup()
		CCP.LoadoutCrate.PerformLayout = CCFramePerformLayout
		CCP.LoadoutCrate:PerformLayout()

		CCP.LoadoutCrate.Think = UIAutoClose

		CCP.LoadoutCrate.WarningLabel = vgui.Create("DLabel", CCP.LoadoutCrate)
		CCP.LoadoutCrate.WarningLabel:SetText("Be sure to only take what you need - you can only carry so much.")
		CCP.LoadoutCrate.WarningLabel:SetPos(10, 34)
		CCP.LoadoutCrate.WarningLabel:SetSize(570, 14)
		CCP.LoadoutCrate.WarningLabel:SetFont("CombineControl.LabelSmall")
		CCP.LoadoutCrate.WarningLabel:PerformLayout()
		CCP.LoadoutCrate.WarningLabel:SetWrap(true)
		CCP.LoadoutCrate.WarningLabel:SetAutoStretchVertical(true)

		CCP.LoadoutCrate.Pane = vgui.Create("DScrollPanel", CCP.LoadoutCrate)
		CCP.LoadoutCrate.Pane:SetSize(570, 406)
		CCP.LoadoutCrate.Pane:SetPos(10, 84)

		function CCP.LoadoutCrate.Pane:Paint(w, h)
			surface.SetDrawColor(30, 30, 30, 255)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(20, 20, 20, 100)
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		local y = 0

		for _, v in pairs(loadout) do
			local itemdata = assert(GAMEMODE.Items[v], "invalid loadout item " .. tostring(v) .. " for '" .. tostring(flag.Flag) .. "'")

			local itempane = vgui.Create("DPanel")
			itempane:SetPos(0, y)
			itempane:SetSize(556, 64)
			itempane.Item = v

			function itempane:Paint(w, h)
				surface.SetDrawColor(0, 0, 0, 70)
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(0, 0, 0, 100)
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			local icon = vgui.Create("DModelPanel", itempane)
			icon:SetPos(0, 0)
			icon:SetModel(itemdata.Model)
			icon:SetSize(64, 64)

			if itemdata.LookAt then
				icon:SetFOV(itemdata.FOV)
				icon:SetCamPos(itemdata.CamPos)
				icon:SetLookAt(itemdata.LookAt)
			else
				local a, b = icon.Entity:GetModelBounds()

				icon:SetFOV(20)
				icon:SetCamPos(Vector(math.abs(a.x), math.abs(a.y), math.abs(a.z)) * 5)
				icon:SetLookAt((a + b) / 2)
			end

			if itemdata.IconMaterial then icon.Entity:SetMaterial(itemdata.IconMaterial) end
			if itemdata.IconSkin then icon.Entity:SetSkin(itemdata.IconSkin) end
			if itemdata.IconColor then icon.Entity:SetColor(itemdata.IconColor) end

			icon.Entity:SetBodygroup(itemdata.BodygroupCategory or 1, itemdata.Bodygroup or 0)

			function icon:LayoutEntity() end

			local p = icon.Paint

			function icon:Paint(w, h)
				if IsValid(CCP.CombineCrate.Pane) then
					local pnl = CCP.CombineCrate.Pane
					local x2, y2 = pnl:LocalToScreen(0, 0)
					local w2, h2 = pnl:GetSize()
					render.SetScissorRect(x2, y2, x2 + w2, y2 + h2, true)

				end

				p(self, w, h)

				if IsValid(CCP.CombineCrate.Pane) then

					render.SetScissorRect(0, 0, 0, 0, false)

				end
			end

			local name = vgui.Create("DLabel", itempane)
			name:SetText(itemdata.Name)
			name:SetPos(74, 10)
			name:SetFont("CombineControl.LabelSmall")
			name:SizeToContents()
			name:PerformLayout()

			local d = GAMEMODE:FormatLine(itemdata.Description, "CombineControl.LabelTiny", 416)

			local desc = vgui.Create("DLabel", itempane)
			desc:SetText(d)
			desc:SetPos(74, 24)
			desc:SetFont("CombineControl.LabelTiny")
			desc:SizeToContents()
			desc:PerformLayout()

			local take = vgui.Create("DButton", itempane)
			take:SetFont("CombineControl.LabelSmall")
			take:SetText("Take")
			take:SetPos(500, 30)
			take:SetSize(46, 24)

			function take:DoClick()
				local item = self:GetParent().Item

				if not LocalPlayer():CanTakeItem(item) then
					GAMEMODE:AddChat("That's too heavy for you to carry.", Color(200, 0, 0, 255))

					return
				end

				if LocalPlayer():HasItem(item) then
					GAMEMODE:AddChat("You already have one of those.", Color(200, 0, 0, 255))

					return
				end

				if not LocalPlayer()["CombineCrate_Next" .. item] then
					LocalPlayer()["CombineCrate_Next" .. item] = 0
				end

				if CurTime() >= LocalPlayer()["CombineCrate_Next" .. item] then
					LocalPlayer()["CombineCrate_Next" .. item] = CurTime() + GAMEMODE.LoadoutDelay

					net.Start("nTakeLoadout")
						net.WriteString(item)
					net.SendToServer()

					self:SetDisabled(true)
				end
			end

			if LocalPlayer()["CombineCrate_Next" .. itempane.Item] and CurTime() < LocalPlayer()["CombineCrate_Next" .. itempane.Item] or LocalPlayer():HasItem(itempane.Item) then
				take:SetDisabled(true)
			end

			take:PerformLayout()

			CCP.CombineCrate.Pane:Add(itempane)

			y = y + 64
		end
	end
	net.Receive("nLoadoutCrate", nLoadoutCrate)

	function nLoadoutCrateNotAllowed(len)
		GAMEMODE:AddChat("You can't seem to find anything useful in this crate.", Color(200, 0, 0, 255))
	end
	net.Receive("nLoadoutCrateNotAllowed", nLoadoutCrateNotAllowed)
else
	function nTakeLoadout(len, ply)
		local item = net.ReadString()
		local loadout = ply:GetCharFlagAttribute("ItemLoadout")

		if loadout and table.HasValue(loadout, item) then
			if not ply:CanTakeItem(item) then
				return
			end

			if ply:HasItem(item) then
				return
			end

			if not ply["CombineCrate_Next" .. item] then
				ply["CombineCrate_Next" .. item] = 0
			end

			if CurTime() >= ply["CombineCrate_Next" .. item] then
				ply["CombineCrate_Next" .. item] = CurTime() + GAMEMODE.LoadoutDelay
				ply:GiveItem(item, 1)
			end
		end
	end
	net.Receive("nTakeLoadout", nTakeLoadout)
end
