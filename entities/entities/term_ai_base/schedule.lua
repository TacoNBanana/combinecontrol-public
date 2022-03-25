DEFINE_BASECLASS("base_ai")

ENT.Schedules = {}

function ENT:AddSchedule(scheduleObject, interruptHandler)
	self.Schedules[scheduleObject.DebugName] = {scheduleObject, interruptHandler}
end

include("schedules/seek.lua")
include("schedules/wander.lua")
include("schedules/attack.lua")

include("schedules/control_idle.lua")
include("schedules/control_moveto.lua")
include("schedules/control_attack.lua")

function ENT:GetCustomSchedule(schedule)
	return unpack(self.Schedules[schedule])
end

function ENT:SetCustomSchedule(schedule)
	local scheduleObject, interruptHandler = self:GetCustomSchedule(schedule)

	self.ActiveSchedule = schedule

	self.InterruptHandler = interruptHandler
	self:StartSchedule(scheduleObject)
end

function ENT:ScheduleFinished()
	BaseClass.ScheduleFinished(self)

	self.LastSchedule = self.ActiveSchedule
	self.ActiveSchedule = nil
	self.InterruptHandler = nil
end
