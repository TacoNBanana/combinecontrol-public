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

function GM:DrawStencilEnt(ent, thermal)
	ent:DrawModel()

	local body, ext

	if ent:IsPlayer() then
		body = Entity(ent:CompoundBodyEnt())
		ext = Entity(ent:CompoundExtEnt())
	else
		body = Entity(ent:GetNWInt("CompoundBody", -1))
		ext = Entity(ent:GetNWInt("CompoundExt", -1))
	end

	if IsValid(body) then
		body:DrawModel()
	end

	if IsValid(ext) and not thermal then
		ext:DrawModel()
	end
end

local white = Material("engine/singlecolor")
local colormod = Material("pp/colour")

function ThermalScopeCallback(self)
	render.PushRenderTarget(self.RTScopeTarget)

	local orig_col = colormod:GetTexture("$fbtexture")

	colormod:SetTexture("$fbtexture", self.RTScopeTarget)

	local tab = {}

	table.Add(tab, player.GetAll())
	table.Add(tab, ents.FindByClass("npc_*"))

	render.SetStencilEnable(true)

	render.SetStencilWriteMask(255)
	render.SetStencilTestMask(255)

	render.SetStencilReferenceValue(1)

	render.SetStencilCompareFunction(STENCIL_ALWAYS)

	render.SetStencilPassOperation(STENCIL_REPLACE)
	render.SetStencilFailOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_KEEP)

	render.ClearStencil()

	render.SuppressEngineLighting(true)
	render.MaterialOverride(white)

	cam.Start3D()
		for _, v in pairs(tab) do
			local thermal = v:IsPlayer() and v:ThermalHidden() or false
			local ent = GAMEMODE:ShouldDrawStencilEnt(v)

			if not IsValid(ent) or ent:IsDormant() then
				continue
			end

			GAMEMODE:DrawStencilEnt(ent, thermal)
		end
	cam.End3D()

	render.MaterialOverride()
	render.SuppressEngineLighting(false)

	render.SetStencilCompareFunction(STENCIL_NOTEQUAL)

	DrawColorModify({
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = -0.1,
		["$pp_colour_contrast"] = 0.25,
		["$pp_colour_colour"] = 0,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	})

	DrawColorModify({
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 0,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	})

	render.SetStencilEnable(false)

	colormod:SetTexture("$fbtexture", orig_col)
end