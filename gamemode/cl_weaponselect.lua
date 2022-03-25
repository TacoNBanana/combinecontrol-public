local meta = FindMetaTable("Player")

GM.WeaponSelectOpenTime = 2

GM.WeaponSelectRef = GM.WeaponSelectRef or GM.WeaponSelectOpenTime * -1
GM.WeaponSelectSlot = GM.WeaponSelectSlot or 1
GM.WeaponSelectSlotPos = GM.WeaponSelectSlotPos or 1

hook.Add("CC.CL.PlayerBindPress", "CL.WeaponSelect.PlayerBindPress", function(ply, bind, down)
	if not down then
		return
	end

	if not ply:Alive() then
		return
	end

	if ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2) then
		return
	end

	if ply:TiedUp() or ply:InVehicle() then
		return
	end

	if string.find(bind, "invnext") then
		GAMEMODE:WeaponSelectScrollDown()

		return true
	elseif string.find(bind, "invprev") then
		GAMEMODE:WeaponSelectScrollUp()

		return true
	elseif string.find(bind, "attack") and GAMEMODE:WeaponSelectOpen() then
		GAMEMODE:WeaponSelectClick()

		return true
	elseif string.find(bind, "slot") then
		local a = string.gsub(bind, "slot", "")
		local n = tonumber(a)

		if n == 1 or n == 2 or n == 3 then
			GAMEMODE:WeaponSelectNumber(n)
		end

		return true
	end
end)

function GM:WeaponSelectOpen()
	return CurTime() - self.WeaponSelectRef < self.WeaponSelectOpenTime
end

local function sort(a, b)
	local slot_a = GAMEMODE:WeaponSelectGetSlotPos(a)
	local slot_b = GAMEMODE:WeaponSelectGetSlotPos(b)
	if slot_a == slot_b then
		return GAMEMODE:WeaponSelectGetPrintName(a) < GAMEMODE:WeaponSelectGetPrintName(b)
	else
		return slot_a < slot_b
	end
end

function meta:GetWeaponsInSlot(n)
	local w = self:GetWeapons()
	local t = {}

	for _, v in pairs(w) do
		if GAMEMODE:WeaponSelectGetSlot(v) == n then
			table.insert(t, v)
		end
	end

	table.sort(t, sort)

	return t
end

function meta:FindSlotsFromWeapon()
	local wep = self:GetActiveWeapon()

	if wep ~= NULL then
		GAMEMODE.WeaponSelectSlot = GAMEMODE:WeaponSelectGetSlot(wep)
		GAMEMODE.WeaponSelectSlotPos = GAMEMODE:WeaponSelectGetSlotPos(wep)
	end
end

GM.WeaponSelectEngineNames = {}
GM.WeaponSelectEngineNames["weapon_physgun"] = "Physics Gun"
GM.WeaponSelectEngineNames["weapon_physcannon"] = "Gravity Gun"
GM.WeaponSelectEngineNames["gmod_tool"] = "Toolgun"

GM.OverrideSlots = {}
GM.OverrideSlots["weapon_physgun"] = {3, 1}
GM.OverrideSlots["weapon_physcannon"] = {3, 2}
GM.OverrideSlots["gmod_tool"] = {3, 3}

function GM:WeaponSelectGetPrintName(wep)
	local name = self.WeaponSelectEngineNames[wep:GetClass()]

	if name then
		return name
	end

	if wep.PrintName then
		return wep.PrintName
	end

	return wep:GetClass()
end

function GM:WeaponSelectGetSlot(wep)
	local slot = self.OverrideSlots[wep:GetClass()]

	if slot then
		return slot[1]
	end

	if wep.Slot then
		return wep.Slot
	end

	return 3
end

function GM:WeaponSelectGetSlotPos(wep)
	local slot = self.OverrideSlots[wep:GetClass()]

	if slot then
		return slot[2]
	end

	if wep.SlotPos then
		return wep.SlotPos
	end

	return 1
end

function GM:WeaponSelectGetFirstPos()
	local n = 1

	while LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot)[n] == NULL and n < #LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot) do
		n = n + 1
	end

	return n
end

function GM:WeaponSelectNumber(n)
	if #LocalPlayer():GetWeapons() == 0 then return end
	if #LocalPlayer():GetWeaponsInSlot(n) == 0 then return end

	surface.PlaySound("common/wpn_moveselect.wav")

	if self:WeaponSelectOpen() then

		if self.WeaponSelectSlot == n then

			self.WeaponSelectSlotPos = self.WeaponSelectSlotPos + 1

			while(LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot)[self.WeaponSelectSlotPos] == NULL and self.WeaponSelectSlotPos <= #LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot)) do

				self.WeaponSelectSlotPos = self.WeaponSelectSlotPos + 1

			end

			while(self.WeaponSelectSlotPos > #LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot)) do

				self.WeaponSelectSlotPos = 1

			end

			self.WeaponSelectRef = CurTime()

		else

			self.WeaponSelectSlot = n
			self.WeaponSelectSlotPos = self:WeaponSelectGetFirstPos()

		end

	else

		self.WeaponSelectSlot = n
		self.WeaponSelectSlotPos = self:WeaponSelectGetFirstPos()

	end

	self.WeaponSelectRef = CurTime()
end

function GM:WeaponSelectScrollDown()
	if #LocalPlayer():GetWeapons() == 0 then return end

	surface.PlaySound("common/wpn_moveselect.wav")

	if self:WeaponSelectOpen() then

		self.WeaponSelectSlotPos = self.WeaponSelectSlotPos + 1

		while(LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot)[self.WeaponSelectSlotPos] == NULL and self.WeaponSelectSlotPos <= #LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot)) do

			self.WeaponSelectSlotPos = self.WeaponSelectSlotPos + 1

		end

		while(self.WeaponSelectSlotPos > #LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot)) do

			self.WeaponSelectSlot = self.WeaponSelectSlot + 1
			self.WeaponSelectSlotPos = self:WeaponSelectGetFirstPos()

			if self.WeaponSelectSlot > 3 then

				self.WeaponSelectSlot = 1
				self.WeaponSelectSlotPos = self:WeaponSelectGetFirstPos()

			end

		end

		self.WeaponSelectRef = CurTime()

	else

		LocalPlayer():FindSlotsFromWeapon()
		self.WeaponSelectRef = CurTime()

	end
end

function GM:WeaponSelectScrollUp()
	if #LocalPlayer():GetWeapons() == 0 then return end

	surface.PlaySound("common/wpn_moveselect.wav")

	if self:WeaponSelectOpen() then

		self.WeaponSelectSlotPos = self.WeaponSelectSlotPos - 1

		while(LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot)[self.WeaponSelectSlotPos] == NULL and self.WeaponSelectSlotPos >= 1) do

			self.WeaponSelectSlotPos = self.WeaponSelectSlotPos - 1

		end

		while(self.WeaponSelectSlotPos < 1 or #LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot) == 0) do

			self.WeaponSelectSlot = self.WeaponSelectSlot - 1
			self.WeaponSelectSlotPos = #LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot)

			if self.WeaponSelectSlot < 1 then

				self.WeaponSelectSlot = 3
				self.WeaponSelectSlotPos = self:WeaponSelectGetFirstPos()

			end

		end

		self.WeaponSelectRef = CurTime()

	else

		LocalPlayer():FindSlotsFromWeapon()
		self.WeaponSelectRef = CurTime()

	end
end

function GM:WeaponSelectClick()
	surface.PlaySound("common/wpn_select.wav")

	self.WeaponSelectRef = 0

	if LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot)[self.WeaponSelectSlotPos] and LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot)[self.WeaponSelectSlotPos]:IsValid() then

		net.Start("nSelectWeapon")
			net.WriteString(LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot)[self.WeaponSelectSlotPos]:GetClass())
		net.SendToServer()

	end
end

GM.WeaponSelectWidth = 150

function GM:DrawWeaponSelect()
	local a = 0

	if self:WeaponSelectOpen() then

		local d = CurTime() - self.WeaponSelectRef

		if d < self.WeaponSelectOpenTime - 1 then
			a = 1
		elseif d < self.WeaponSelectOpenTime then
			a = math.abs(d - self.WeaponSelectOpenTime)
		else
			a = 0
		end

	end

	if a > 0 then
		if self.WeaponSelectSlot == 1 then
			draw.RoundedBox(0, ScrW() / 2 - self.WeaponSelectWidth / 2 - 20 - self.WeaponSelectWidth, 20, self.WeaponSelectWidth, 30, Color(30, 30, 30, 200 * a))
			draw.RoundedBox(0, ScrW() / 2 - self.WeaponSelectWidth / 2, 20, self.WeaponSelectWidth, 30, Color(40, 40, 40, 100 * a))
			draw.RoundedBox(0, ScrW() / 2 - self.WeaponSelectWidth / 2 + 20 + self.WeaponSelectWidth, 20, self.WeaponSelectWidth, 30, Color(30, 30, 30, 100 * a))

			draw.DrawTextShadow("Basic", "CombineControl.WepSelectHeader", ScrW() / 2 - 20 - self.WeaponSelectWidth, 25, Color(200, 200, 200, 255 * a), Color(0, 0, 0, 255 * a), 1)
			draw.DrawTextShadow("Weapons", "CombineControl.WepSelectHeader", ScrW() / 2, 25, Color(200, 200, 200, 200 * a), Color(0, 0, 0, 200 * a), 1)
			draw.DrawTextShadow("Misc", "CombineControl.WepSelectHeader", ScrW() / 2 + 20 + self.WeaponSelectWidth, 25, Color(200, 200, 200, 200 * a), Color(0, 0, 0, 200 * a), 1)
		elseif self.WeaponSelectSlot == 2 then
			draw.RoundedBox(0, ScrW() / 2 - self.WeaponSelectWidth / 2 - 20 - self.WeaponSelectWidth, 20, self.WeaponSelectWidth, 30, Color(30, 30, 30, 100 * a))
			draw.RoundedBox(0, ScrW() / 2 - self.WeaponSelectWidth / 2, 20, self.WeaponSelectWidth, 30, Color(30, 30, 30, 200 * a))
			draw.RoundedBox(0, ScrW() / 2 - self.WeaponSelectWidth / 2 + 20 + self.WeaponSelectWidth, 20, self.WeaponSelectWidth, 30, Color(30, 30, 30, 100 * a))

			draw.DrawTextShadow("Basic", "CombineControl.WepSelectHeader", ScrW() / 2 - 20 - self.WeaponSelectWidth, 25, Color(200, 200, 200, 200 * a), Color(0, 0, 0, 200 * a), 1)
			draw.DrawTextShadow("Weapons", "CombineControl.WepSelectHeader", ScrW() / 2, 25, Color(200, 200, 200, 255 * a), Color(0, 0, 0, 255 * a), 1)
			draw.DrawTextShadow("Misc", "CombineControl.WepSelectHeader", ScrW() / 2 + 20 + self.WeaponSelectWidth, 25, Color(200, 200, 200, 200 * a), Color(0, 0, 0, 200 * a), 1)
		else
			draw.RoundedBox(0, ScrW() / 2 - self.WeaponSelectWidth / 2 - 20 - self.WeaponSelectWidth, 20, self.WeaponSelectWidth, 30, Color(30, 30, 30, 100 * a))
			draw.RoundedBox(0, ScrW() / 2 - self.WeaponSelectWidth / 2, 20, self.WeaponSelectWidth, 30, Color(30, 30, 30, 100 * a))
			draw.RoundedBox(0, ScrW() / 2 - self.WeaponSelectWidth / 2 + 20 + self.WeaponSelectWidth, 20, self.WeaponSelectWidth, 30, Color(30, 30, 30, 200 * a))

			draw.DrawTextShadow("Basic", "CombineControl.WepSelectHeader", ScrW() / 2 - 20 - self.WeaponSelectWidth, 25, Color(200, 200, 200, 200 * a), Color(0, 0, 0, 200 * a), 1)
			draw.DrawTextShadow("Weapons", "CombineControl.WepSelectHeader", ScrW() / 2, 25, Color(200, 200, 200, 200 * a), Color(0, 0, 0, 200 * a), 1)
			draw.DrawTextShadow("Misc", "CombineControl.WepSelectHeader", ScrW() / 2 + 20 + self.WeaponSelectWidth, 25, Color(200, 200, 200, 255 * a), Color(0, 0, 0, 255 * a), 1)
		end

		local y = 0

		for k, v in pairs(LocalPlayer():GetWeaponsInSlot(self.WeaponSelectSlot)) do
			if v == NULL then
				continue
			end

			local c = Color(30, 30, 30, 200 * a)

			if self.WeaponSelectSlotPos == k then
				c = Color(100, 40, 40, 200 * a)
			end

			local text = self:WeaponSelectGetPrintName(v)

			surface.SetFont("CombineControl.WepSelectWep")
			local w, h = surface.GetTextSize(text)

			if self.WeaponSelectSlotPos == k then
				local text2 = v.InfoText
				local h2 = 0

				if text2 then
					local expl = string.Explode("\n", text2)
					h2 = 18 * #expl
				end

				draw.RoundedBox(0, ScrW() / 2 - self.WeaponSelectWidth / 2 - 20 - self.WeaponSelectWidth, 70 + y, self.WeaponSelectWidth * 3 + 40, math.max(h, h2) + 20, c)
				draw.DrawTextShadow(text, "CombineControl.WepSelectWep", ScrW() / 2 - self.WeaponSelectWidth / 2 - 20 - self.WeaponSelectWidth + 10, 70 + y + 10, Color(200, 200, 200, 200 * a), Color(0, 0, 0, 200 * a), 0)

				if text2 then
					local expl = string.Explode("\n", text2)

					for k, v in pairs(expl) do
						draw.DrawTextShadow(v, "CombineControl.WepSelectInfo", ScrW() / 2 - self.WeaponSelectWidth / 2 - 20 - self.WeaponSelectWidth + 10 + w + 10, 70 + y + 11 + (k - 1) * 18, Color(200, 200, 200, 200 * a), Color(0, 0, 0, 200 * a), 0)
					end
				end

				y = y + math.max(h, h2) + 30
			else
				draw.RoundedBox(0, ScrW() / 2 - self.WeaponSelectWidth / 2 - 20 - self.WeaponSelectWidth, 70 + y, self.WeaponSelectWidth * 3 + 40, h + 20, c)
				draw.DrawTextShadow(text, "CombineControl.WepSelectWep", ScrW() / 2 - self.WeaponSelectWidth / 2 - 20 - self.WeaponSelectWidth + 10, 70 + y + 10, Color(200, 200, 200, 200 * a), Color(0, 0, 0, 200 * a), 0)

				y = y + h + 30
			end
		end
	end
end