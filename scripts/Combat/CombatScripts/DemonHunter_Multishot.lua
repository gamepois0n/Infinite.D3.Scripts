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

function CombatScript:Defend(player, monsterTarget, isMoving)		
	if AttributeHelper.GetHitpointPercentage(player) <= 50 then
		self:UseHealthPotion()
	end
end

function CombatScript:Buff(player, monsterTarget, isMoving)	
	local elitesTable = Combat.Collector.Actors.Monster.Elites
	local allTable = Combat.Collector.Actors.Monster.All

	table.sort(elitesTable, function(a, b) return a:GetPosition():GetDistanceFromMe() < b:GetPosition():GetDistanceFromMe() end)
	table.sort(allTable, function(a, b) return a:GetPosition():GetDistanceFromMe() < b:GetPosition():GetDistanceFromMe() end)

	if not AttributeHelper.IsBuffActive(player, self.Vengeance.PowerSNO) then
		self.Vengeance:CastAtLocation(player:GetPosition())
	end	

	if Infinity.D3.GetAcdContainerSizeByName("Actors.Monster.Elites") > 0 and elitesTable[1]:GetPosition():GetDistanceFromMe() <= 30 then
		self.Companion:CastAtLocation(player:GetPosition())
	end

	if Infinity.D3.GetAcdContainerSizeByName("Actors.Monster.All") > 0 and AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Buff_Icon_Count1, 359583) ~= 1 and allTable[1]:GetPosition():GetDistanceFromMe() <= 60 then
		self.EvasiveFire:CastAtLocation(allTable[1]:GetPosition())
	end	

	if Infinity.D3.GetAcdContainerSizeByName("Actors.Monster.All") > 0 and AttributeHelper.GetPrimaryResourcePercentage(player) <= 20 and allTable[1]:GetPosition():GetDistanceFromMe() <= 60 then
		self.EvasiveFire:CastAtLocation(allTable[1]:GetPosition())
	end

	if AttributeHelper.GetPrimaryResourcePercentage(player) <= 15 then
		self.Preparation:CastAtLocation(player:GetPosition())
	end	
end

function CombatScript:Attack(player, monsterTarget, isMoving)		
	if InputHelper.IsSpacePressed() and Infinity.D3.GetAcdContainerSizeByName("Actors.Monster.Boss") > 0 and Infinity.D3.GetAcdContainerByName("Actors.Monster.Boss")[1]:GetPosition():GetDistanceFromMe() <= 60 then
		self.Multishot:CastAtLocation(Infinity.D3.GetAcdContainerByName("Actors.Monster.Boss")[1]:GetPosition())
	end
end


return CombatScript()