Skill = { }
Skill.__index = Skill

setmetatable(Skill, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Skill:new(name, powersno )
  local self = setmetatable({}, Skill)
  
  self.Name = name
  self.PowerSNO = powersno

  self.LastCast = 0
  self.ForcedCooldown = 0
    
  return self
end

function Skill:CastAtLocation(targetPosition)
	if not self:isUsable() then
		return false
	end

	Infinity.D3.CastPowerAtLocation(self.PowerSNO, targetPosition)
		
	self.LastCast = Infinity.Win32.GetTickCount()

	return true
end

function Skill:CastAtCursorLocation()
	if not self:isUsable() then
		return false
	end

	Infinity.D3.CastPowerAtCursorLocation(self.PowerSNO)
	
	self.LastCast = Infinity.Win32.GetTickCount()

	return true
end

function Skill:SetForcedCooldown(cooldown)
	self.ForcedCooldown = cooldown
end

function Skill:isUsable()		
	if SkillHelper.GetActiveSkill(self.PowerSNO) ~= nil and not SkillHelper.IsOnCooldown(self.PowerSNO) then		
		if self.ForcedCooldown > 0 then
			if self.LastCast + self.ForcedCooldown < Infinity.Win32.GetTickCount() then				
				return true
			else
				return false
			end
		else
			return true
		end

		return true
	end

	return false
end
