BULLET = class.Create("bullet_ballistic")
DEFINE_BASECLASS("bullet_ballistic")

BULLET.CDamage = 25

function BULLET:Callback(attacker, trace, dmginfo)
	if not SERVER then
		return
	end

	local ent = trace.Entity
	if not IsValid(ent) then
		return
	end

	if ent:IsPlayer() then
		ent:TakeCDamage(self.CDamage)
	elseif ent:GetClass() == "prop_ragdoll" and IsValid(ent:PropFakePlayer()) then
		ent:PropFakePlayer():TakeCDamage(self.CDamage)
	elseif ent:IsVehicle() and IsValid(ent:GetDriver()) then
		ent:GetDriver():TakeCDamage(self.CDamage)
	end

end