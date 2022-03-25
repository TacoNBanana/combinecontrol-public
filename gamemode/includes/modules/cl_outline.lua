-- TODO: Remove if https://github.com/Facepunch/garrysmod/pull/1590 is ever merged

OUTLINE_MODE_BOTH	= 0
OUTLINE_MODE_NOTVISIBLE	= 1
OUTLINE_MODE_VISIBLE	= 2

module("outline", package.seeall)

local List = {}
local RenderEnt = NULL

local OutlineMatSettings = {
	["$ignorez"] = 1,
	["$alphatest"] = 1
}

local CopyMat		= Material("pp/copy")
local OutlineMat	= CreateMaterial("OutlineMat", "UnlitGeneric", OutlineMatSettings)
local StoreTexture	= render.GetScreenEffectTexture(0)
local DrawTexture	= render.GetScreenEffectTexture(1)

local ENTS	= 1
local COLOR	= 2
local MODE	= 3

function Add(tab, color, mode)
	if #List >= 255 then return end				--Maximum 255 reference values
	if not istable(tab) then tab = {tab} end	--Support for passing Entity as first argument
	if not tab[1] then return end				--Do not pass empty tables

	table.insert(List, {
		[ENTS] = tab,
		[COLOR] = color,
		[MODE] = mode or OUTLINE_MODE_BOTH
	})
end

function RenderedEntity()
	return RenderEnt
end

local function Render()
	local ply = LocalPlayer()
	local scene = render.GetRenderTarget()

	render.CopyRenderTargetToTexture(StoreTexture)

	local w = ScrW()
	local h = ScrH()

	render.Clear(0, 0, 0, 0, true, true)

	render.SetStencilEnable(true)
		cam.IgnoreZ(true)
		render.SuppressEngineLighting(true)

		render.SetStencilWriteMask(0xFF)
		render.SetStencilTestMask(0xFF)

		render.SetStencilCompareFunction(STENCIL_ALWAYS)

		render.SetStencilFailOperation(STENCIL_KEEP)
		render.SetStencilZFailOperation(STENCIL_REPLACE)
		render.SetStencilPassOperation(STENCIL_REPLACE)

		cam.Start3D()
			for k, v in ipairs(List) do
				local mode = v[MODE]
				local tab = v[ENTS]

				local parent = tab[1]
				local sight = ply:IsLineOfSightClear(parent)

				local visible = (mode == OUTLINE_MODE_VISIBLE and sight) or (mode == OUTLINE_MODE_NOTVISIBLE and not sight)

				render.SetStencilReferenceValue(k)

				for _, ent in ipairs(tab) do
					if not IsValid(ent) or not visible then
						continue
					end

					RenderEnt = ent

					ent:DrawModel()
				end
			end

			RenderEnt = NULL
		cam.End3D()

		render.SetStencilCompareFunction(STENCIL_EQUAL)

		cam.Start2D()
			for k, v in ipairs(List) do
				render.SetStencilReferenceValue(k)

				surface.SetDrawColor(v[COLOR])
				surface.DrawRect(0, 0, w, h)
			end
		cam.End2D()

		render.SuppressEngineLighting(false)
		cam.IgnoreZ(false)
	render.SetStencilEnable(false)

	render.CopyRenderTargetToTexture(DrawTexture)

	render.SetRenderTarget(scene)

	CopyMat:SetTexture("$basetexture", StoreTexture)

	render.SetMaterial(CopyMat)
	render.DrawScreenQuad()

	render.SetStencilEnable(true)
		render.SetStencilReferenceValue(0)
		render.SetStencilCompareFunction(STENCIL_EQUAL)

		OutlineMat:SetTexture("$basetexture", DrawTexture)

		render.SetMaterial(OutlineMat)

		render.DrawScreenQuadEx(-1, -1, w, h)
		render.DrawScreenQuadEx(-1, 0, w, h)
		render.DrawScreenQuadEx(-1, 1, w, h)
		render.DrawScreenQuadEx(0, -1, w, h)
		render.DrawScreenQuadEx(0, 1, w, h)
		render.DrawScreenQuadEx(1, 1, w, h)
		render.DrawScreenQuadEx(1, 0, w, h)
		render.DrawScreenQuadEx(1, 1, w, h)
	render.SetStencilEnable(false)
end

hook.Add("PostDrawEffects", "RenderOutlines", function()
	hook.Run("PreDrawOutlines")

	if #List == 0 then
		return
	end

	Render()

	List = {}
end)