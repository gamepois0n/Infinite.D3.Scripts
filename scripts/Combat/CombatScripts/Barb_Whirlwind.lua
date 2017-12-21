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

function CombatScript:Defend(player, monsterTarget)		
	if AttributeHelper.GetHitpointPercentage(player) <= 50 then
		self:UseHealthPotion()
	end
end

function CombatScript:Buff(player, monsterTarget)	
	local nearby = TargetHelper.GetMonsterCountAroundLocalPlayer(25)

	if not AttributeHelper.IsBuffActive(player, self.BattleRage.PowerSNO) then
		self.BattleRage:CastAtLocation(player:GetPosition())
	end

	if not AttributeHelper.IsBuffActive(player, self.WarCry.PowerSNO) then
		self.WarCry:CastAtLocation(player:GetPosition())
	end

	if not AttributeHelper.IsBuffActive(player, self.WoTB.PowerSNO) and nearby >= 1 then
		self.WoTB:CastAtLocation(player:GetPosition())
	end

	if not AttributeHelper.IsBuffActive(player, self.Sprint.PowerSNO) then
		self.Sprint:CastAtLocation(player:GetPosition())
	end	
end

function CombatScript:Attack(player, monsterTarget)		
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