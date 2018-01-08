--[[
AUTHOR		R3p
]]--

CombatScript = { }
CombatScript.__index = CombatScript

setmetatable(CombatScript, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CombatScript.new()
	local instance = {}
	local self = setmetatable(instance, CombatScript)
		
	instance.Whirlwind = Skill:new("Whirlwind", 96296)
	instance.BattleRage = Skill:new("BattleRage", 79076)
	instance.WoTB = Skill:new("WoTB", 79607)
	instance.WarCry = Skill:new("WarCry", 375483)
	instance.Sprint = Skill:new("Sprint", 78551)
	instance.FuriousCharge = Skill:new("FuriousCharge", 97435)
	instance.FuriousCharge:SetForcedCooldown(2000)
		
	return self
end

function CombatScript:UseHealthPotion()
	UIInteractionHelper.UseFunctionByName("UI_PotionButton_OnLeftClick")
end

function CombatScript:Defend(player, monsterTarget, isMoving)		
	if AttributeHelper.GetHitpointPercentage(player) <= 50 then
		self:UseHealthPotion()
	end
end

CombatScript.MoveSet = false
CombatScript.NonMoveSet = false

function CombatScript:Buff(player, monsterTarget, isMoving)	
	if isMoving and not self.MoveSet then		
		if Combat.ApplyParagonPointSet(1) then
			self.MoveSet = true
			self.NonMoveSet = false
		else
			self.MoveSet = false
			self.NonMoveSet = false
		end
	elseif not isMoving and not self.NonMoveSet then		
		if Combat.ApplyParagonPointSet(2) then
			self.MoveSet = false
			self.NonMoveSet = true
		else
			self.MoveSet = false
			self.NonMoveSet = false
		end
	end

	if not isMoving then
		return
	end

	local nearby = TargetHelper.GetACDsAroundLocalPlayer(Combat.Collector.Actors.Monster.All, 25)

	if not AttributeHelper.IsBuffActive(player, self.BattleRage.PowerSNO) then
		self.BattleRage:CastAtLocation(player:GetPosition())
	end

	if not AttributeHelper.IsBuffActive(player, self.WarCry.PowerSNO) then
		self.WarCry:CastAtLocation(player:GetPosition())
	end

	if not AttributeHelper.IsBuffActive(player, self.WoTB.PowerSNO) and table.length(nearby) > 0 then
		self.WoTB:CastAtLocation(player:GetPosition())
	end

	if not AttributeHelper.IsBuffActive(player, self.Sprint.PowerSNO) then
		self.Sprint:CastAtLocation(player:GetPosition())
	end	
end

function CombatScript:Attack(player, monsterTarget, isMoving)		
	if monsterTarget ~= nil and monsterTarget:GetActorType() == Enums.ActorType.Monster and monsterTarget:GetMonsterQuality() == Boss then			
		self.Whirlwind:CastAtLocation(monsterTarget:GetPosition())
	end
	
	if monsterTarget ~= nil and AttributeHelper.GetSkillCharges(player, self.FuriousCharge.PowerSNO) >= 1 then			
		self.FuriousCharge:CastAtLocation(monsterTarget:GetPosition())
	end

	if InputHelper.IsSpacePressed() then
		self.Whirlwind:CastAtCursorLocation()
	end
end


return CombatScript()