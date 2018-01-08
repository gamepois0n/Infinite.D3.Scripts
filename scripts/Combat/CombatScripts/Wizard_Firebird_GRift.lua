--[[
AUTHOR		R3p
]]--


CombatScript = { }
CombatScript.__index = CombatScript
CombatScript.Target = nil

setmetatable(CombatScript, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CombatScript.new()
	local instance = {}
	local self = setmetatable(instance, CombatScript)
		
	instance.ArcaneTorrent = Skill:new("ArcaneTorrent", 134456)	
	instance.StormArmor = Skill:new("StormArmor", 74499)	
	instance.WaveOfForce = Skill:new("WaveOfForce", 30796)
	instance.WaveOfForce:SetForcedCooldown(1000)
	instance.Electrocute = Skill:new("Electrocute", 1765)	
	instance.Meteor = Skill:new("Meteor", 69190)	
	instance.MagicWeapon = Skill:new("MagicWeapon", 76108)	
		
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
	if not AttributeHelper.IsBuffActive(player, self.StormArmor.PowerSNO, 3) then
		self.StormArmor:CastAtLocation(player:GetPosition())
	end

	if not AttributeHelper.IsBuffActive(player, self.MagicWeapon.PowerSNO) then
		self.MagicWeapon:CastAtLocation(player:GetPosition())
	end
end

function CombatScript:Attack(player, monsterTarget, isMoving)		
	if InputHelper.IsSpacePressed() then
		if self.Target == nil then
			local bossTable = Combat.Collector.Actors.Monster.Boss
			if Infinity.D3.GetAcdContainerSizeByName("Actors.Monster.Boss") > 0 then
				self.Target = bossTable[1]
			else
				local elitesTable = Combat.Collector.Actors.Monster.Elites

				if Infinity.D3.GetAcdContainerSizeByName("Actors.Monster.Elites") > 0 then
					table.sort(elitesTable, function(a, b) return a:GetPosition():GetDistanceFromMe() < b:GetPosition():GetDistanceFromMe() end)
					local elites60yards = TargetHelper.GetACDsAroundLocalPlayer(elitesTable, 60)

					self.Target = elites60yards[1]
				end
			end
		end

		if self.Target == nil then
			print("Target = nil")
			return
		end

		local fbStacks = AttributeHelper.GetBuffCount(player, 359581, 5)
		local dynStacks = AttributeHelper.GetBuffCount(player, 208823, 1)
		local wofStacks = AttributeHelper.GetBuffCount(player, 30796, 2)
		local currentAP = AttributeHelper.GetPrimaryResourcePercentage(player)

		local coeArcaneEndTick = AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Buff_Icon_End_Tick1, 430674)
		local coeLightningEndTick = AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Buff_Icon_End_Tick5, 430674)

		local isCoEArcanePhase = coeArcaneEndTick > 0
		local isCoELightningPhase = coeLightningEndTick > 0

		local isMeteorPending = Infinity.D3.GetAcdContainerSizeByName("Actors.WizardMeteor.ArcanePending") ~= 0
		local isMeteorImpact = Infinity.D3.GetAcdContainerSizeByName("Actors.WizardMeteor.ArcaneImpact") ~= 0

		if fbStacks ~= 20 and AttributeHelper.GetAttributeValue(self.Target, Enums.AttributeId.Power_Buff_4_Visual_Effect_None, 359581) ~= 1 then			
			if AttributeHelper.GetAttributeValue(self.Target, Enums.AttributeId.Power_Buff_1_Visual_Effect_None, 359581) > 0 then
				if self.ArcaneTorrent:CastAtLocation(self.Target:GetPosition()) then
					print("Trying to get FB Stacks of 20")
					return				
				end
			else
				if self.Electrocute:CastAtLocation(self.Target:GetPosition()) then
					print("Trying to get FB Stacks of 20")
					return
				end
			end			
		end

		if not isMeteorPending then -- Execute this if no Arcane Meteor is Pending (was cast)
			if fbStacks == 20 and wofStacks == 0 and self.Target:GetPosition():GetDistanceFromMe() <= 20 then
				if	self.WaveOfForce:CastAtLocation(player:GetPosition()) then
					print("Trying to get WoF Stacks")
					return
				end
			end

			if fbStacks == 20 and wofStacks > 0 and (currentAP < 100 or dynStacks < 5) then
				if	self.Electrocute:CastAtLocation(self.Target:GetPosition()) then
					print("Trying to get max AP / Dyn Stacks")
					return
				end
			end		
		
			if isCoELightningPhase then -- if CoE Lightning phase check for 90 ticks ( 1.5sec ) before Lightning ends
				local tickLeft = coeLightningEndTick - Infinity.D3.GetGameTick()

				if tickLeft <= 80 and fbStacks == 20 and dynStacks == 5 and currentAP == 100 then									
					if self.Meteor:CastAtLocation(self.Target:GetPosition()) then
						print("Pre-Arcane Phase Meteor Cast")
						return
					end
				end
			elseif isCoEArcanePhase then -- if CoE Arcane phase cast instant if true
				if fbStacks == 20 and dynStacks == 5 and currentAP == 100 then
					if self.Meteor:CastAtLocation(self.Target:GetPosition()) then
						print("Arcane Phase Meteor Cast")
						return
					end
				end
			end

		elseif isMeteorPending and not isMeteorImpact then -- Execute this if a Meteor is Pending (was cast) and if there is no Meteor Impact yet
			if currentAP <= 5 then -- if not enough ArcanePower for ArcaneTorrent
				if self.Electrocute:CastAtLocation(self.Target:GetPosition()) then
					print("Meteor Pending but not enough AP, casting Electrocute")
					return
				end
			else
				if self.ArcaneTorrent:CastAtLocation(self.Target:GetPosition()) then -- Cast Arcane Torrent until Meteor Impact
					print("Meteor Pending casting Arcane Torrent")
					return 
				end
			end					
		end
	else
		self.Target = nil
	end
end


return CombatScript()