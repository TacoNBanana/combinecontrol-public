hook.Add("PreDrawPlayerHands", "CL.Weapon.PreDrawPlayerHands", function(_, _, _, weapon)
	return weapon.Tekka
end)

hook.Add("Think", "CL.Weapon.Think", function()
	local weapon = LocalPlayer():GetActiveWeapon()
	local vm = LocalPlayer():GetViewModel()

	if not IsValid(weapon) then
		return
	end

	if IsValid(vm) then
		if weapon.Tekka then
			vm:SetMaterial("engine/occlusionproxy")
		else
			vm:SetMaterial()
		end
	end
end)

hook.Add("RenderScene", "CL.Weapon.RenderScene", function()
	local ply = LocalPlayer()
	local weapon = ply:GetActiveWeapon()

	if IsValid(weapon) and weapon.Tekka and weapon.UseRTScope then
		weapon:DrawRTScope()
	end
end)

local colormod = Material("pp/colour")

function GM:ShouldDrawStencilEnt(ent)
	if ent:IsNPC() and ent:Health() > 0 then
		return ent
	elseif ent:IsPlayer() and ent:Alive() then
		local ragdoll = ent:Ragdoll()

		if IsValid(ragdoll) then
			return ragdoll
		end

		return not ent:GetNoDraw() and ent or false
	end

	return false
end

function GM:DrawStencilEnt(ent)
	ent:DrawModel()

	if ent.GetActiveWeapon and IsValid(ent:GetActiveWeapon()) then
		ent:GetActiveWeapon():DrawModel()
	end

	if ent:IsPlayer() then
		local body = Entity(ent:CompoundBodyEnt())
		local ext = Entity(ent:CompoundExtEnt())

		if IsValid(body) then
			body:DrawModel()
		end

		if IsValid(ext) then
			ext:DrawModel()
		end
	else
		local body = Entity(ent:GetNWInt("CompoundBody", -1))
		local ext = Entity(ent:GetNWInt("CompoundExt", -1))

		if IsValid(body) then
			body:DrawModel()
		end

		if IsValid(ext) then
			ext:DrawModel()
		end
	end
end

function ThermalScopeCallback(self)
	local orig = colormod:GetTexture("$fbtexture")

	colormod:SetTexture("$fbtexture", self.RTScopeTarget)

	DrawColorModify({
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 1,
		["$pp_colour_brightness"] = -1,
		["$pp_colour_contrast"] = 0.25,
		["$pp_colour_colour"] = 2,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	})

	colormod:SetTexture("$fbtexture", orig)

	local tab = {}

	table.Add(tab, player.GetAll())
	table.Add(tab, ents.FindByClass("npc_*"))

	cam.Start3D()
		render.ClearStencil()
		render.SetStencilEnable(true)
			render.SetStencilWriteMask(255)
			render.SetStencilTestMask(255)

			render.SetStencilReferenceValue(15)

			render.SetStencilPassOperation(STENCIL_REPLACE)
			render.SetStencilFailOperation(STENCIL_KEEP)
			render.SetStencilZFailOperation(STENCIL_KEEP)

			render.SetStencilCompareFunction(STENCIL_ALWAYS)

			render.SetBlend(0)

			for _, v in pairs(tab) do
				local ent = GAMEMODE:ShouldDrawStencilEnt(v)

				if not ent then
					continue
				end
				GAMEMODE:DrawStencilEnt(ent)
			end

			render.SetBlend(1)

			render.SetStencilCompareFunction(STENCIL_EQUAL)

			cam.Start2D()
				surface.SetDrawColor(255, 93, 0, 255)
				surface.DrawRect(0, 0, ScrW(), ScrH())
			cam.End2D()
		render.SetStencilEnable(false)
	cam.End3D()
end