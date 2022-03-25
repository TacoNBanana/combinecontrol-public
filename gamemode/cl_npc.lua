GM.MastermindMouse = nil

net.Receive("nRequestNPCData", function(len, ply)
	local ent = net.ReadEntity()

	ent:SyncNPCData(ply)
end)

function GM:GUIMousePressed(code, aim) -- TODO: Look into this, not always called when clicking mouse w/ context menu

	if self.Mastermind then

		self.MastermindMouse = code
		local hEnt = nil

		if vgui.IsHoveringWorld() then

			hEnt = self:GetCursorNPC(200)

		end

		if hEnt then

			self.MastermindSelected = hEnt

		end

	else

		if vgui.IsHoveringWorld() then

			if code == 108 then

				gui.EnableScreenClicker(false)
				CloseDermaMenus()

			else

				if self.CCContext then

					self:CreateCCContext(self:GetCursorEnt())

				end

			end

		end

	end
end

function GM:GUIMouseReleased(code, aim)
	if self.MastermindSelected and self.MastermindSelected:IsValid() then

		if code == self.MastermindMouse then

			local trace = {}
			trace.start = LocalPlayer():GetShootPos()
			trace.endpos = trace.start + aim * 32768
			trace.filter = LocalPlayer()
			local tr = util.TraceLine(trace)

			if code == 107 then

				net.Start("nNMMGoTo")
					net.WriteEntity(self.MastermindSelected)
					net.WriteVector(tr.HitPos)
				net.SendToServer()

			elseif code == 108 then

				net.Start("nNMMWalkTo")
					net.WriteEntity(self.MastermindSelected)
					net.WriteVector(tr.HitPos)
				net.SendToServer()

			elseif code == 109 then

				net.Start("nNMMGoTo")
					net.WriteEntity(self.MastermindSelected)
					net.WriteVector(LocalPlayer():GetPos())
				net.SendToServer()

			end

			self.MastermindSelected = nil
			self.MastermindMouse = nil

		end

	end
end

function GM:GetNPCModifiers(ent)
	local tab = {}

	table.insert(tab, {"Mastermind Color", "mcolor"})

	if ent:GetClass() == "npc_helicopter" then

		table.insert(tab, {"Firing Enabled", "helifiring", function(ent) return tobool(ent:NPCGunOn()) end})
		table.insert(tab, {"Drop Bomb", "helibomb"})
		table.insert(tab, {"Explode", "heliexplode"})

	elseif ent:GetClass() == "npc_combinegunship" then

		table.insert(tab, {"Firing Enabled", "helifiring", function(ent) return tobool(ent:NPCGunOn()) end})
		table.insert(tab, {"Explode", "heliexplode"})

	else

		table.insert(tab, {"Kill", "kill"})

	end

	table.insert(tab, {"Hate Weapons", "hateweapons", function(ent) return tobool(ent:NPCHatesWeapons()) end})
	table.insert(tab, {"Remove", "remove"})

	return tab
end

function GM:CreateNPCModifier(panel, npc, t)
	if t == "mcolor" then

		local col = npc:NPCMastermindColor()

		CCP.MColor = vgui.Create("DFrame")
		CCP.MColor:SetSize(300, 200)
		CCP.MColor:Center()
		CCP.MColor:SetTitle("Mastermind Color")
		CCP.MColor.lblTitle:SetFont("CombineControl.Window")
		CCP.MColor.PerformLayout = CCFramePerformLayout
		CCP.MColor:PerformLayout()
		CCP.MColor:MakePopup()

		CCP.MColor.Think = UIAutoClose

		CCP.MColor.Mixer = vgui.Create("DColorMixer", CCP.MColor)
		CCP.MColor.Mixer:Dock(FILL)
		CCP.MColor.Mixer:SetPalette(true)
		CCP.MColor.Mixer:SetAlphaBar(false)
		CCP.MColor.Mixer:SetWangs(true)
		CCP.MColor.Mixer:SetColor(Color(col.x, col.y, col.z, 255))
		function CCP.MColor.Mixer:ValueChanged(col)

			if npc and npc:IsValid() then

				net.Start("nNMMSetMastermindColor")
					net.WriteEntity(npc)
					net.WriteVector(Vector(col.r, col.g, col.b))
				net.SendToServer()

			end

			if panel:GetParentNode() and panel:GetParentNode():IsValid() then

				panel:GetParentNode():SetIconColor(Vector(col.r, col.g, col.b))

			end

		end

	end

	if t == "apcfiring" then

		if npc:NPCGunOn() == 1 then

			net.Start("nNMMFireInput")
				net.WriteEntity(npc)
				net.WriteString("DisableFiring")
				net.WriteString("")
				net.WriteBit(true)
			net.SendToServer()

			net.Start("nNMMGunOn")
				net.WriteEntity(npc)
				net.WriteFloat(0)
			net.SendToServer()

			panel:SetBulletColor(Vector(255, 255, 255))

		else

			net.Start("nNMMFireInput")
				net.WriteEntity(npc)
				net.WriteString("EnableFiring")
				net.WriteString("")
				net.WriteBit(true)
			net.SendToServer()

			net.Start("nNMMGunOn")
				net.WriteEntity(npc)
				net.WriteFloat(1)
			net.SendToServer()

			panel:SetBulletColor(Vector(255, 0, 0))

		end

	end

	if t == "apcexplode" then

		net.Start("nNMMFireInput")
			net.WriteEntity(npc)
			net.WriteString("Destroy")
			net.WriteString("")
			net.WriteBit(false)
		net.SendToServer()

		local root = panel:GetRoot()
		panel:GetParentNode():Remove()
		root:PerformLayout()

		return true

	end

	if t == "helifiring" then

		if npc:NPCGunOn() == 1 then

			net.Start("nNMMFireInput")
				net.WriteEntity(npc)
				net.WriteString("GunOff")
				net.WriteString("")
				net.WriteBit(false)
			net.SendToServer()

			net.Start("nNMMGunOn")
				net.WriteEntity(npc)
				net.WriteFloat(0)
			net.SendToServer()

			panel:SetBulletColor(Vector(255, 255, 255))

		else

			net.Start("nNMMFireInput")
				net.WriteEntity(npc)
				net.WriteString("GunOn")
				net.WriteString("")
				net.WriteBit(false)
			net.SendToServer()

			net.Start("nNMMGunOn")
				net.WriteEntity(npc)
				net.WriteFloat(1)
			net.SendToServer()

			panel:SetBulletColor(Vector(255, 0, 0))

		end

	end

	if t == "helibomb" then

		net.Start("nNMMFireInput")
			net.WriteEntity(npc)
			net.WriteString("DropBomb")
			net.WriteString("")
			net.WriteBit(false)
		net.SendToServer()

	end

	if t == "heliexplode" then

		net.Start("nNMMFireInput")
			net.WriteEntity(npc)
			net.WriteString("SelfDestruct")
			net.WriteString("")
			net.WriteBit(false)
		net.SendToServer()

		local root = panel:GetRoot()
		panel:GetParentNode():Remove()
		root:PerformLayout()

		return true

	end

	if t == "hateunflagged" then

		if npc:NPCHatesUnflaggedCPs() == 1 then

			net.Start("nNMMHateUnflagged")
				net.WriteEntity(npc)
				net.WriteFloat(0)
			net.SendToServer()

			panel:SetBulletColor(Vector(255, 255, 255))

		else

			net.Start("nNMMHateUnflagged")
				net.WriteEntity(npc)
				net.WriteFloat(1)
			net.SendToServer()

			panel:SetBulletColor(Vector(255, 0, 0))

		end

	end

	if t == "hateflagged" then

		if npc:NPCHatesFlaggedCPs() == 1 then

			net.Start("nNMMHateFlagged")
				net.WriteEntity(npc)
				net.WriteFloat(0)
			net.SendToServer()

			panel:SetBulletColor(Vector(255, 255, 255))

		else

			net.Start("nNMMHateFlagged")
				net.WriteEntity(npc)
				net.WriteFloat(1)
			net.SendToServer()

			panel:SetBulletColor(Vector(255, 0, 0))

		end

	end

	if t == "hatecitizens" then

		if npc:NPCHatesCitizens() == 1 then

			net.Start("nNMMHateCitizens")
				net.WriteEntity(npc)
				net.WriteFloat(0)
			net.SendToServer()

			panel:SetBulletColor(Vector(255, 255, 255))

		else

			net.Start("nNMMHateCitizens")
				net.WriteEntity(npc)
				net.WriteFloat(1)
			net.SendToServer()

			panel:SetBulletColor(Vector(255, 0, 0))

		end

	end

	if t == "haterebels" then

		if npc:NPCHatesRebels() == 1 then

			net.Start("nNMMHateRebels")
				net.WriteEntity(npc)
				net.WriteFloat(0)
			net.SendToServer()

			panel:SetBulletColor(Vector(255, 255, 255))

		else

			net.Start("nNMMHateRebels")
				net.WriteEntity(npc)
				net.WriteFloat(1)
			net.SendToServer()

			panel:SetBulletColor(Vector(255, 0, 0))

		end

	end

	if t == "hateweapons" then

		if npc:NPCHatesWeapons() == 1 then

			net.Start("nNMMHateWeapons")
				net.WriteEntity(npc)
				net.WriteFloat(0)
			net.SendToServer()

			panel:SetBulletColor(Vector(255, 255, 255))

		else

			net.Start("nNMMHateWeapons")
				net.WriteEntity(npc)
				net.WriteFloat(1)
			net.SendToServer()

			panel:SetBulletColor(Vector(255, 0, 0))

		end

	end

	if t == "kill" then

		net.Start("nNMMKill")
			net.WriteEntity(npc)
		net.SendToServer()

		local root = panel:GetRoot()
		panel:GetParentNode():Remove()
		root:PerformLayout()

		return true

	end

	if t == "remove" then

		net.Start("nNMMFireInput")
			net.WriteEntity(npc)
			net.WriteString("Kill")
			net.WriteString("")
			net.WriteBit(false)
		net.SendToServer()

		local root = panel:GetRoot()
		panel:GetParentNode():Remove()
		root:PerformLayout()

		return true

	end
end

function GM:CreateNPCCreatorMenu()
	if CCP.NCM and CCP.NCM:IsValid() then

		CCP.NCM:Remove()
		return

	end

	CCP.NCM = vgui.Create("DFrame")
	CCP.NCM:SetPos(0, 0)
	CCP.NCM:SetSize(300, ScrH())
	CCP.NCM:SetTitle("Mastermind Creator Menu")
	CCP.NCM.lblTitle:SetFont("CombineControl.Window")
	CCP.NCM:SetDraggable(false)
	CCP.NCM.PerformLayout = CCFramePerformLayout
	CCP.NCM:PerformLayout()
	CCP.NCM:MakePopup()
	CCP.NCM:SetKeyboardInputEnabled(false)

	CCP.NCM.Tree = vgui.Create("CCTree", CCP.NCM)
	CCP.NCM.Tree:SetPos(10, 34)
	CCP.NCM.Tree:SetSize(280, ScrH() - 34 - 10)
	CCP.NCM.Tree:SetShowIcons(false)

	local node = CCP.NCM.Tree:AddNode("Shake (Small)")
	node:SetExpanded(true)
	node:SetBulletColor(Vector(255, 255, 255))
	function node:DoClick()

		net.Start("nNCMShake")
			net.WriteFloat(100)
			net.WriteFloat(1)
			net.WriteFloat(1)
		net.SendToServer()

	end

	local node = CCP.NCM.Tree:AddNode("Shake (Medium)")
	node:SetExpanded(true)
	node:SetBulletColor(Vector(255, 255, 255))
	function node:DoClick()

		net.Start("nNCMShake")
			net.WriteFloat(100)
			net.WriteFloat(10)
			net.WriteFloat(2)
		net.SendToServer()

	end

	local node = CCP.NCM.Tree:AddNode("Shake (Large)")
	node:SetExpanded(true)
	node:SetBulletColor(Vector(255, 255, 255))
	function node:DoClick()

		net.Start("nNCMShake")
			net.WriteFloat(100)
			net.WriteFloat(30)
			net.WriteFloat(5)
		net.SendToServer()

	end

	local node = CCP.NCM.Tree:AddNode("Headcrab Pod (Regular)")
	node:SetExpanded(true)
	node:SetBulletColor(Vector(255, 255, 255))
	function node:DoClick()

		RunConsoleCommand("rpa_spawncanister", "5", "regular")

	end

	local node = CCP.NCM.Tree:AddNode("Headcrab Pod (Fast)")
	node:SetExpanded(true)
	node:SetBulletColor(Vector(255, 255, 255))
	function node:DoClick()

		RunConsoleCommand("rpa_spawncanister", "3", "fast")

	end

	local node = CCP.NCM.Tree:AddNode("Headcrab Pod (Poison)")
	node:SetExpanded(true)
	node:SetBulletColor(Vector(255, 255, 255))
	function node:DoClick()

		RunConsoleCommand("rpa_spawncanister", "3", "poison")

	end

	local node = CCP.NCM.Tree:AddNode("Headcrab Pod (Empty)")
	node:SetExpanded(true)
	node:SetBulletColor(Vector(255, 255, 255))
	function node:DoClick()

		RunConsoleCommand("rpa_spawncanister", "0", "regular")

	end

	local node = CCP.NCM.Tree:AddNode("Combine Mortar (Single)")
	node:SetExpanded(true)
	node:SetBulletColor(Vector(255, 255, 255))
	function node:DoClick()

		RunConsoleCommand("rpa_spawnmortar")
		
	end

	local node = CCP.NCM.Tree:AddNode("Explosion")
	node:SetExpanded(true)
	node:SetBulletColor(Vector(255, 255, 255))
	function node:DoClick()

		RunConsoleCommand("rpa_createexplosion")

	end

	local node = CCP.NCM.Tree:AddNode("Fire (30s)")
	node:SetExpanded(true)
	node:SetBulletColor(Vector(255, 255, 150))
	function node:DoClick()

		RunConsoleCommand("rpa_createfire", "30")

	end

	local node = CCP.NCM.Tree:AddNode("Fire (60s)")
	node:SetExpanded(true)
	node:SetBulletColor(Vector(255, 255, 150))
	function node:DoClick()

		RunConsoleCommand("rpa_createfire", "60")

	end

	local node = CCP.NCM.Tree:AddNode("Fire (5 min)")
	node:SetExpanded(true)
	node:SetBulletColor(Vector(255, 255, 150))
	function node:DoClick()

		RunConsoleCommand("rpa_createfire", "300")

	end

	local node = CCP.NCM.Tree:AddNode("Fire (20 min)")
	node:SetExpanded(true)
	node:SetBulletColor(Vector(255, 255, 150))
	function node:DoClick()

		RunConsoleCommand("rpa_createfire", "1200")

	end
end

function GM:CreateNPCModifierMenu()
	if CCP.NMM and CCP.NMM:IsValid() then

		CCP.NMM:Remove()
		return

	end

	CCP.NMM = vgui.Create("DFrame")
	CCP.NMM:SetPos(ScrW() - 300, 0)
	CCP.NMM:SetSize(300, ScrH())
	CCP.NMM:SetTitle("Mastermind Modifier Menu")
	CCP.NMM.lblTitle:SetFont("CombineControl.Window")
	CCP.NMM:SetDraggable(false)
	CCP.NMM.PerformLayout = CCFramePerformLayout
	CCP.NMM:PerformLayout()
	CCP.NMM:MakePopup()
	CCP.NMM:SetKeyboardInputEnabled(false)

	CCP.NMM.Tree = vgui.Create("CCTree", CCP.NMM)
	CCP.NMM.Tree:SetPos(10, 34)
	CCP.NMM.Tree:SetSize(280, ScrH() - 34 - 10)
	CCP.NMM.Tree:SetShowIcons(false)

	for _, v in pairs(ents.GetNPCs()) do

		local node = CCP.NMM.Tree:AddNode("#" .. v:GetClass())
		node:SetExpanded(true)
		node:SetIconColor(v:NPCMastermindColor())

		for _, n in pairs(self:GetNPCModifiers(v)) do

			local option = node:AddNode(n[1])

			if n[3] and n[3](v) then

				option:SetBulletColor(Vector(255, 0, 0))

			else

				option:SetBulletColor(Vector(255, 255, 255))

			end

			function option:DoClick()

				if v and v:IsValid() then

					local ret = GAMEMODE:CreateNPCModifier(self, v, n[2])

					if ret then

						self:Remove()

					end

				end

			end

		end

	end
end
