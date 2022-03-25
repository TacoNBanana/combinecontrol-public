net.Receive("nCBuyDoor", function(len, ply)
	if ply:TiedUp() then return end
	if ply:PassedOut() then return end

	local ent = net.ReadEntity()

	if ply:GetPos():Distance(ent:GetPos()) > 128 then return end

	if ent and ent:IsValid() and ent:IsDoor() and (ent:DoorType() == DOOR_BUYABLE or ent:DoorType() == DOOR_BUYABLE_ASSIGNABLE) and #ent:DoorOwners() == 0 and #ent:DoorAssignedOwners() == 0 and not ply:HasTerminatorTeam() then

		if ply:Money() >= ent:DoorPrice() then
			ply:BuyDoor(ent)
		end
	end
end)

net.Receive("nCSellDoor", function(len, ply)
	if ply:TiedUp() then return end
	if ply:PassedOut() then return end

	local ent = net.ReadEntity()

	if ply:GetPos():Distance(ent:GetPos()) > 128 then return end

	if IsValid(ent) and ent:IsDoor() and (ent:DoorType() == DOOR_BUYABLE or ent:DoorType() == DOOR_BUYABLE_ASSIGNABLE) and table.HasValue(ent:DoorOwners(), ply:CharID()) then
		ply:SellDoor(ent)
	end
end)

net.Receive("nCLockUnlock", function(len, ply)
	if ply:TiedUp() then return end
	if ply:PassedOut() then return end

	local ent = net.ReadEntity()

	if ply:GetPos():Distance(ent:GetPos()) > 128 then return end

	if IsValid(ent) and ent:IsDoor() and ply:CanLock(ent) then
		if ent:GetSaveTable().m_bLocked then
			ply:EmitSound("doors/door_latch3.wav", 100, math.random(90, 110))
			ent:Fire("Unlock")
		else
			ply:EmitSound("doors/door_locked2.wav", 100, math.random(90, 110))
			ent:Fire("Lock")
		end
	end
end)

net.Receive("nCNameDoor", function(len, ply)
	if ply:TiedUp() then return end
	if ply:PassedOut() then return end

	local ent = net.ReadEntity()
	local val = net.ReadString()

	if ply:GetPos():Distance(ent:GetPos()) > 128 then return end

	if IsValid(ent) and ent:IsDoor() and table.HasValue(ent:DoorOwners(), ply:CharID()) then
		if #val <= 50 and #val >= 1 then
			ent:SetDoorName(val)
		end
	end
end)

net.Receive("nCMakeOwner", function(len, ply)
	if ply:TiedUp() then return end
	if ply:PassedOut() then return end

	local ent = net.ReadEntity()
	local targ = net.ReadEntity()

	if ply:GetPos():Distance(ent:GetPos()) > 128 then return end

	if IsValid(ent) and ent:IsDoor() and table.HasValue(ent:DoorOwners(), ply:CharID()) then
		if targ and targ:IsValid() and not table.HasValue(ent:DoorOwners(), targ:CharID()) and not targ:HasTerminatorTeam() then
			targ:AddDoorOwner(ent)
		end
	end
end)

net.Receive("nCRemoveOwner", function(len, ply)
	if ply:TiedUp() then return end
	if ply:PassedOut() then return end

	local ent = net.ReadEntity()
	local targ = net.ReadEntity()

	if ply:GetPos():Distance(ent:GetPos()) > 128 then return end

	if IsValid(ent) and ent:IsDoor() and table.HasValue(ent:DoorOwners(), ply:CharID()) then
		if targ and targ:IsValid() and table.HasValue(ent:DoorOwners(), targ:CharID()) and not targ:HasTerminatorTeam() then
			targ:RemoveDoorOwner(ent)
		end
	end
end)

net.Receive("nCGiveMoney", function(len, ply)
	if ply:TiedUp() then return end
	if ply:PassedOut() then return end

	local amt = math.floor(net.ReadFloat())
	local targ = net.ReadEntity()

	if ply:GetPos():Distance(targ:GetPos()) > 128 then return end

	if amt > 0 and ply:Money() >= amt then
		ply:AddMoney(-amt)
		targ:AddMoney(amt)

		ply:UpdateCharacterField("Money", tostring(ply:Money()))
		targ:UpdateCharacterField("Money", tostring(targ:Money()))

		GAMEMODE:WriteLog("character_givemoney", {
			Ply = GAMEMODE:LogPlayer(ply),
			Char = GAMEMODE:LogCharacter(ply),
			TargetPly = GAMEMODE:LogPlayer(targ),
			TargetChar = GAMEMODE:LogCharacter(targ),
			Amount = amt
		})

		net.Start("nCReceiveMoney")
			net.WriteFloat(amt)
			net.WriteEntity(ply)
		net.Send(targ)
	end
end)

net.Receive("nCPatDownStart", function(len, ply)
	local targ = net.ReadEntity()

	if ply:GetPos():Distance(targ:GetPos()) > 128 then return end

	local mul = 1

	net.Start("nCreateTimedProgressBar")
		net.WriteFloat(5 * mul)
		net.WriteString("Being pat down...")
		net.WriteEntity(ply)
	net.Send(targ)
end)

net.Receive("nCPatDown", function(len, ply)
	if ply:TiedUp() then return end
	if ply:PassedOut() then return end

	local targ = net.ReadEntity()

	if not IsValid(targ) then
		return
	end

	if ply:GetPos():Distance(targ:GetPos()) > 128 then return end
	if targ:GetVelocity():Length2D() > 5 then return end

	for _, v in pairs(targ.Inventory) do
		v:AddNetworkedPlayer(ply)
	end

	net.Start("nCPattedDown")
		net.WriteEntity(targ)
	net.Send(ply)
end)

net.Receive("nClosePatDown", function(len, ply)
	local targ = net.ReadEntity()

	if not IsValid(targ) then
		return
	end

	for _, v in pairs(targ.Inventory) do
		v:RemoveNetworkedPlayer(ply)
	end
end)

net.Receive("nCTieUpStart", function(len, ply)
	if not ply:HasItem("zipties") then return end

	local targ = net.ReadEntity()

	if ply:GetPos():Distance(targ:GetPos()) > 128 then return end

	net.Start("nCreateTimedProgressBar")
		net.WriteFloat(5)
		net.WriteString("Being tied up...")
		net.WriteEntity(ply)
	net.Send(targ)
end)

net.Receive("nCTieUp", function(len, ply)
	if ply:TiedUp() then return end
	if ply:PassedOut() then return end

	local targ = net.ReadEntity()

	if ply:GetPos():Distance(targ:GetPos()) > 128 then return end

	if targ:GetVelocity():Length2D() <= 5 and ply:HasItem("zipties") then

		targ:SetTiedUp(true)
		for _, v in pairs(GAMEMODE.HandsWeapons) do
			if targ:HasWeapon(v) then
				targ:SelectWeapon(v)
				break
			end
		end

		GAMEMODE:WriteLog("character_tie", {
			Ply = GAMEMODE:LogPlayer(ply),
			Char = GAMEMODE:LogCharacter(ply),
			TargetPly = GAMEMODE:LogPlayer(targ),
			TargetChar = GAMEMODE:LogCharacter(targ)
		})
	end
end)

net.Receive("nCUntieStart", function(len, ply)
	local targ = net.ReadEntity()

	if ply:GetPos():Distance(targ:GetPos()) > 128 then return end

	net.Start("nCreateTimedProgressBar")
		net.WriteFloat(2)
		net.WriteString("Being untied...")
		net.WriteEntity(ply)
	net.Send(targ)
end)

net.Receive("nCUntie", function(len, ply)
	if ply:TiedUp() then return end
	if ply:PassedOut() then return end

	local targ = net.ReadEntity()

	if ply:GetPos():Distance(targ:GetPos()) > 128 then return end

	if targ:GetVelocity():Length2D() <= 5 then
		targ:SetTiedUp(false)

		GAMEMODE:WriteLog("character_untie", {
			Ply = GAMEMODE:LogPlayer(ply),
			Char = GAMEMODE:LogCharacter(ply),
			TargetPly = GAMEMODE:LogPlayer(targ),
			TargetChar = GAMEMODE:LogCharacter(targ)
		})
	end
end)

net.Receive("nCSlitThroat", function(len, ply)
	if ply:TiedUp() then return end
	if ply:PassedOut() then return end

	local targ = net.ReadEntity()

	if ply:GetPos():Distance(targ:GetPos()) > 64 then return end

	if targ:PassedOut() and ply:HasItem("weapon_cc_knife") and targ:GetVelocity():Length2D() <= 5 then
		ply:SelectWeapon("weapon_cc_knife")
		ply:SetHolstered(false)

		ply:EmitSound("Weapon_Knife.Hit")

		local dmg = DamageInfo()
		dmg:SetAttacker(ply)
		dmg:SetDamage(200)
		dmg:SetDamageForce(Vector(0, 0, 1))
		dmg:SetDamagePosition(targ:GetPos())
		dmg:SetDamageType(DMG_SLASH)
		dmg:SetInflictor(ply:GetWeapon("weapon_cc_knife"))

		targ:TakeDamageInfo(dmg)
	end
end)

net.Receive("nCRadioChannel", function(len, ply)
	local targ = net.ReadEntity()
	local val = net.ReadFloat()

	if ply:GetPos():Distance(targ:GetPos()) > 128 then return end

	if targ:GetClass() == "cc_radio" then
		if val >= 0 and val <= 999 then
			targ:SetChannel(val)
		end
	end
end)