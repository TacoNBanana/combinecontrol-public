local meta = FindMetaTable("Player")

hook.Add("CC.SV.PlayerDeath", "SV.Drugs.PlayerDeath", function(ply)
	if ply.DrugEffects then
		ply:ClearDrug()

		net.Start("nResetDrugFX")
		net.Send(ply)
	end
end)

function meta:ClearDrug()
	self.DrugEffects = {}
end

function meta:DoDrug(d)
	if not self.DrugEffects then self:ClearDrug() end

	self.DrugEffects[d] = CurTime()
end

function meta:HasDrug(d)
	if not self.DrugEffects then self:ClearDrug() end

	if self.DrugEffects[d] then

		return CurTime() - self.DrugEffects[d] < 60

	end

	return false
end

function meta:DrugSpeedMod()
	local mul = 1

	if self:HasDrug(DRUG_ANTLION) or self:HasDrug(DRUG_COP) then

		mul = mul * 1.25

	end

	return mul
end

function meta:DrugDamageMod()
	local mul = 1

	if self:HasDrug(DRUG_MEDKIT) then

		mul = mul * 0.7

	elseif self:HasDrug(DRUG_ANTLION) or self:HasDrug(DRUG_COP) then

		mul = mul * 0.4

	elseif self:HasDrug(DRUG_EXTRACT) then

		mul = mul * 0.25

	end

	return mul
end

function meta:DrugPerceptionMod()
	local mul = 0

	if GAMEMODE.DrugType == DRUG_BREEN then

		mul = 50

	end

	return mul
end