--[[
AUTHOR		Pete
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
		
	instance.Sprint = Skill:new("Sprint", 78551)
	instance.ThreateningShout = Skill:new("ThreateningShout", 79077)
	instance.WarCry = Skill:new("WarCry", 375483)
	instance.IgnorePain = Skill:new("IgnorePain", 79528)
	instance.AncientSpear = Skill:new("AncientSpear", 377453)
	instance.Whirlwind = Skill:new("Whirlwind", 96296)
		
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

function CombatScript:IsBuffNotActive(player, playerlist, powerSNO)
	for k,actordata in pairs(playerlist) do
		layer = 0
		if actordata:GetActorId() ~= player:GetActorId() then
			layer = 1
		end
		if AttributeHelper.GetHitpointPercentage(actordata) > 0.001 then	-- is alive?
			if not AttributeHelper.IsBuffActive(actordata, powerSNO, layer) then
				return true
			end
		end
	end	
	return false
end

function CombatScript:Buff(player, monsterTarget, isMoving)	
	table.sort(Combat.Collector.Actors.Monster.All, function(a, b) return a:GetPosition():GetDistanceFromMe() < b:GetPosition():GetDistanceFromMe() end)
	table.sort(Combat.Collector.Actors.Player, function(a, b) return a:GetPosition():GetDistanceFromMe() < b:GetPosition():GetDistanceFromMe() end)

	local monster25y = TargetHelper.GetACDsAroundLocalPlayer(Combat.Collector.Actors.Monster.All, 25)
	local players50y = TargetHelper.GetACDsAroundLocalPlayer(Combat.Collector.Actors.Player, 50)
	local players100y = TargetHelper.GetACDsAroundLocalPlayer(Combat.Collector.Actors.Player, 100)
	
	local rescur = AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Resource_Cur, 2)
	local resmax = AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Resource_Max, 2)

	if (Combat.Collector.PlayerData.OthersCount+1) == table.length(players50y) and rescur > 100 then
		if self:IsBuffNotActive(player, players50y, self.Sprint.PowerSNO) then
			self.Sprint:CastAtLocation(player:GetPosition())
		end
	end

	if (not AttributeHelper.IsBuffActive(player, self.ThreateningShout.PowerSNO) and table.length(monster25y) > 0) or (rescur+15) < resmax then
		self.ThreateningShout:CastAtLocation(player:GetPosition())
	end

	if (Combat.Collector.PlayerData.OthersCount+1) == table.length(players100y) then
		if self:IsBuffNotActive(player, players100y, self.WarCry.PowerSNO) then
			self.WarCry:CastAtLocation(player:GetPosition())
		end
	end

	if (Combat.Collector.PlayerData.OthersCount+1) == table.length(players50y) then
		if self:IsBuffNotActive(player, players50y, self.IgnorePain.PowerSNO) then
			self.IgnorePain:CastAtLocation(player:GetPosition())
		end
	end
end

function CombatScript:Attack(player, monsterTarget, isMoving)		
	if InputHelper.IsSpacePressed() then
		self.Whirlwind:CastAtCursorLocation()
	end
end


return CombatScript()
