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
		
	instance.Multishot = Skill:new("Multishot", 77649)
	instance.Multishot:SetForcedCooldown(500)
	instance.EvasiveFire = Skill:new("EvasiveFire", 377450)
	instance.EvasiveFire:SetForcedCooldown(500)
	instance.Preparation = Skill:new("Preparation", 129212)
	instance.Companion = Skill:new("Companion", 365311)
	instance.Vengeance = Skill:new("Vengeance", 302846)
	instance.Vault = Skill:new("Vault", 111215)
		
	return self
end

function CombatScript:UseHealthPotion()
	UIInteractionHelper.UseFunctionByName("UI_PotionButton_OnLeftClick")
end

function CombatScript:Defend(player, monsterTarget)	
	if player == nil then
		return
	end

	if AttributeHelper.IsInTown(player) or AttributeHelper.IsTeleportingTown(player) then
		return
	end

	if AttributeHelper.GetHitpointPercentage(player) <= 50 then
		self:UseHealthPotion()
	end
end

function CombatScript:Buff(player, monsterTarget)	
	if player == nil then
		return
	end

	if AttributeHelper.IsInTown(player) or AttributeHelper.IsTeleportingTown(player) then
		return
	end
	
	table.sort(Combat.Collector.Actors.Monster.Elites, function(a, b) return a:GetPosition():GetDistanceFromMe() < b:GetPosition():GetDistanceFromMe() end)
	table.sort(Combat.Collector.Actors.Monster.All, function(a, b) return a:GetPosition():GetDistanceFromMe() < b:GetPosition():GetDistanceFromMe() end)

	if not AttributeHelper.IsBuffActive(player, self.Vengeance.PowerSNO) then
		self.Vengeance:CastAtLocation(player:GetPosition())
	end	

	if table.length(Combat.Collector.Actors.Monster.Elites) > 0 and Combat.Collector.Actors.Monster.Elites[1]:GetPosition():GetDistanceFromMe() <= 30 then
		self.Companion:CastAtLocation(player:GetPosition())
	end

	if table.length(Combat.Collector.Actors.Monster.All) > 0 and AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Buff_Icon_Count1, 359583) ~= 1 and Combat.Collector.Actors.Monster.All[1]:GetPosition():GetDistanceFromMe() <= 60 then
		self.EvasiveFire:CastAtLocation(Combat.Collector.Actors.Monster.All[1]:GetPosition())
	end	

	if table.length(Combat.Collector.Actors.Monster.All) > 0 and (AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Resource_Cur, 5) / AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Resource_Max_Total, 5)) <= 0.20 and Combat.Collector.Actors.Monster.All[1]:GetPosition():GetDistanceFromMe() <= 60 then
		self.EvasiveFire:CastAtLocation(Combat.Collector.Actors.Monster.All[1]:GetPosition())
	end

	if (AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Resource_Cur, 6) / AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Resource_Max_Total, 6)) <= 0.15 then
		self.Preparation:CastAtLocation(player:GetPosition())
	end	
end

function CombatScript:Attack(player, monsterTarget)		
	if player == nil then
		return
	end
	
	if AttributeHelper.IsInTown(player) or AttributeHelper.IsTeleportingTown(player) then
		return
	end
		
	if InputHelper.IsSpacePressed() and table.length(Combat.Collector.Actors.Monster.Boss) > 0 and Combat.Collector.Actors.Monster.Boss[1]:GetPosition():GetDistanceFromMe() <= 60 then
		self.Multishot:CastAtLocation(Combat.Collector.Actors.Monster.Boss[1]:GetPosition())
	end
end


return CombatScript()