if GM.PrivateMode then
	function ccShowInv(ply, cmd, args)

		MsgN(tostring(#ply.Inventory) .. " ITEMS")

		for k, v in pairs(ply.Inventory) do

			MsgN(tostring(k))

			for l, q in pairs(v) do

				MsgN("\t\"" .. l .. "\"\t" .. type(q) .. "\t\"" .. tostring(q) .. "\"")

			end

		end

	end
	concommand.Add("rp_dev_showinv", ccShowInv)

	function ccSetConscious(ply, cmd, args)

		ply:SetConsciousness(math.Clamp(tonumber(args[1]), 0, 100))

		if ply:Consciousness() <= 0 and not ply:PassedOut() then

			ply:PassOut()

		end

	end
	concommand.Add("rp_dev_setconsc", ccSetConscious)

	function ccMakeDoorDev(ply, cmd, args)

		if not args[1] then

			MsgN("rpa_doordev (unbuyable buyable combineopen combinelock assignable) name price building")
			return

		end

		local doortype = tonumber(args[1]) or DOOR_UNBUYABLE
		local name = args[2] or ""
		local price = tonumber(args[3]) or 0
		local building = args[4] or ""

		local trace = {}
		trace.start = ply:GetShootPos()
		trace.endpos = trace.start + ply:GetAimVector() * 32768
		trace.filter = ply
		local tr = util.TraceLine(trace)

		if tr.Entity and tr.Entity:IsValid() and tr.Entity:IsDoor() then

			local pos = tr.Entity:GetPos()

			local typestr = ""
			if doortype == 0 then typestr = "DOOR_UNBUYABLE" end
			if doortype == 1 then typestr = "DOOR_BUYABLE" end
			if doortype == 2 then typestr = "DOOR_COMBINEOPEN" end
			if doortype == 3 then typestr = "DOOR_COMBINELOCK" end
			if doortype == 4 then typestr = "DOOR_BUYABLE_ASSIGNABLE" end

			if price == 0 and building == "" then

				MsgN("{Vector(" .. tostring(pos.x) .. ", " .. tostring(pos.y) .. ", " .. tostring(pos.z) .. "), " .. typestr .. ", \"" .. name .. "\"},")

			elseif building == "" then

				MsgN("{Vector(" .. tostring(pos.x) .. ", " .. tostring(pos.y) .. ", " .. tostring(pos.z) .. "), " .. typestr .. ", \"" .. name .. "\", " .. tostring(price) .. "},")

			else

				MsgN("{Vector(" .. tostring(pos.x) .. ", " .. tostring(pos.y) .. ", " .. tostring(pos.z) .. "), " .. typestr .. ", \"" .. name .. "\", " .. tostring(price) .. ", \"" .. building .. "\"},")

			end

			tr.Entity:SetDoorType(doortype)
			tr.Entity:SetDoorOriginalName(name)
			tr.Entity:SetDoorName(name)
			tr.Entity:SetDoorPrice(price)
			tr.Entity:SetDoorBuilding(building)

		end

	end
	concommand.Add("rp_dev_doordev", ccMakeDoorDev)

	function ccDoorDevAll(ply, cmd, args)

		MsgN("GM.DoorData = {")

		local t = game.GetDoors()
		table.sort(t, function(a, b)
			return a:DoorBuilding() < b:DoorBuilding()
		end)

		for _, v in pairs(t) do

			if v:DoorType() == 0 and v:DoorOriginalName() == "" and v:DoorPrice() == 0 and v:DoorBuilding() == "" then continue end

			local pos = v:GetPos()

			local typestr = ""
			if v:DoorType() == 0 then typestr = "DOOR_UNBUYABLE" end
			if v:DoorType() == 1 then typestr = "DOOR_BUYABLE" end
			if v:DoorType() == 2 then typestr = "DOOR_COMBINEOPEN" end
			if v:DoorType() == 3 then typestr = "DOOR_COMBINELOCK" end
			if v:DoorType() == 4 then typestr = "DOOR_BUYABLE_ASSIGNABLE" end

			local name = v:DoorOriginalName()
			local price = v:DoorPrice()
			local building = v:DoorBuilding()

			if price == 0 and building == "" then

				MsgN("\t{Vector(" .. tostring(pos.x) .. ", " .. tostring(pos.y) .. ", " .. tostring(pos.z) .. "), " .. typestr .. ", \"" .. name .. "\"},")

			elseif building == "" then

				MsgN("\t{Vector(" .. tostring(pos.x) .. ", " .. tostring(pos.y) .. ", " .. tostring(pos.z) .. "), " .. typestr .. ", \"" .. name .. "\", " .. tostring(price) .. "},")

			else

				MsgN("\t{Vector(" .. tostring(pos.x) .. ", " .. tostring(pos.y) .. ", " .. tostring(pos.z) .. "), " .. typestr .. ", \"" .. name .. "\", " .. tostring(price) .. ", \"" .. building .. "\"},")

			end

		end

		MsgN("}")

	end
	concommand.Add("rp_dev_doordevall", ccDoorDevAll)

	function ccGetSeatPos(ply, cmd, args)

		if not ply:IsAdmin() then return end

		for _, v in pairs(ents.FindByClass("prop_vehicle_prisoner_pod")) do

			if not v.Static then

				local p = v:GetPos() - Vector(0, 0, 4)
				local a = v:GetAngles()
				MsgN("{Vector(" .. tostring(math.ceil(p.x)) .. ", " .. tostring(math.ceil(p.y)) .. ", " .. tostring(math.ceil(p.z)) .. "), Angle(0, " .. tostring(math.ceil(a.y)) .. ", 0)},")

			end

		end

	end
	concommand.Add("rp_dev_getseatpositions", ccGetSeatPos)
end