AttributeHelper = {}
AttributeHelper.AttributeDescriptors = Infinity.D3.GetAttributeDescriptors()
AttributeHelper.PowerSNOs = Infinity.D3.GetPowerSNOs()
AttributeHelper.ItemSNOs = Infinity.D3.GetItemSNOs()

function AttributeHelper.GetItemName(item)
  return AttributeHelper.ItemSNOs[item:GetGameBalanceID()]
end

function AttributeHelper.GetAttributeValue(acd, attribid, modifier)	
	if modifier == nil then
		modifier = -1
	end

  if acd == nil or acd.Address == 0 then
    return 0
  end

	local valueType = AttributeHelper.AttributeDescriptors[attribid]:GetDataType()

	if valueType == 1 then
		return acd:GetAttributeValueInt32(attribid, modifier)
	end

	return acd:GetAttributeValueFloat(attribid, modifier)
end

function AttributeHelper.GetAllAttributes(acd)	
	local buffer = {}

  	local attributes = acd:GetAttributes()

  	for k,v in pairs(attributes) do  		  	
      	local attribDescriptor = AttributeHelper.AttributeDescriptors[v:GetId()]
   
   		if attribDescriptor ~= nil then
   			local value = v:GetValueInt32()

      		if attribDescriptor:GetDataType() == 0 then
      			value = v:GetValueFloat()
      		end

      		if value > 0 then
      			local powerName = AttributeHelper.PowerSNOs[v:GetModifier()]

      			if v:GetModifier() == -1 or powerName == nil then
        			powerName = ""
      			end
      	  
        		table.insert(buffer, {Address = v.Address, AttributeId = v:GetId(), AttributeName = attribDescriptor:GetName(), PowerSNO = v:GetModifier(), PowerName = powerName, Value = value})           
        	end
      	end      	
  	end

  return buffer
end

function AttributeHelper.GetAllBuffCountAttributes(acd)  
  local buffer = {}

    local attributes = acd:GetAttributes()

    for k,v in pairs(attributes) do
      if v:GetModifier() ~= -1 and v:GetId() >= Enums.AttributeId.Buff_Icon_Count0 and v:GetId() <= Enums.AttributeId.Buff_Icon_Count31 then         
        local attribDescriptor = AttributeHelper.AttributeDescriptors[v:GetId()]
   
      if attribDescriptor ~= nil then
        local value = v:GetValueInt32()

          if attribDescriptor:GetDataType() == 0 then
            value = v:GetValueFloat()
          end

          if value > 0 then
            local powerName = AttributeHelper.PowerSNOs[v:GetModifier()]

            if v:GetModifier() == -1 or powerName == nil then
              powerName = ""
            end
          
            table.insert(buffer, {Address = v.Address, AttributeId = v:GetId(), AttributeName = attribDescriptor:GetName(), PowerSNO = v:GetModifier(), PowerName = powerName, Value = value})           
          end
        end
        end       
    end

  return buffer
end

function AttributeHelper.GetAllBuffStartTickAttributes(acd)  
  local buffer = {}

    local attributes = acd:GetAttributes()

    for k,v in pairs(attributes) do
      if v:GetModifier() ~= -1 and v:GetId() >= Enums.AttributeId.Buff_Icon_Start_Tick0 and v:GetId() <= Enums.AttributeId.Buff_Icon_Start_Tick31 then         
        local attribDescriptor = AttributeHelper.AttributeDescriptors[v:GetId()]
   
      if attribDescriptor ~= nil then
        local value = v:GetValueInt32()

          if attribDescriptor:GetDataType() == 0 then
            value = v:GetValueFloat()
          end

          if value > 0 then
            local powerName = AttributeHelper.PowerSNOs[v:GetModifier()]

            if v:GetModifier() == -1 or powerName == nil then
              powerName = ""
            end
          
            table.insert(buffer, {Address = v.Address, AttributeId = v:GetId(), AttributeName = attribDescriptor:GetName(), PowerSNO = v:GetModifier(), PowerName = powerName, Value = value})           
          end
        end
        end       
    end

  return buffer
end

function AttributeHelper.GetAllBuffEndTickAttributes(acd)  
  local buffer = {}

    local attributes = acd:GetAttributes()

    for k,v in pairs(attributes) do
      if v:GetModifier() ~= -1 and v:GetId() >= Enums.AttributeId.Buff_Icon_End_Tick0 and v:GetId() <= Enums.AttributeId.Buff_Icon_End_Tick31 then         
        local attribDescriptor = AttributeHelper.AttributeDescriptors[v:GetId()]
   
      if attribDescriptor ~= nil then
        local value = v:GetValueInt32()

          if attribDescriptor:GetDataType() == 0 then
            value = v:GetValueFloat()
          end

          if value > 0 then
            local powerName = AttributeHelper.PowerSNOs[v:GetModifier()]

            if v:GetModifier() == -1 or powerName == nil then
              powerName = ""
            end
          
            table.insert(buffer, {Address = v.Address, AttributeId = v:GetId(), AttributeName = attribDescriptor:GetName(), PowerSNO = v:GetModifier(), PowerName = powerName, Value = value})           
          end
        end
        end       
    end

  return buffer
end

function AttributeHelper.GetAllBuffAttributes(acd)  
  local buffer = {}

    local attributes = acd:GetAttributes()

    for k,v in pairs(attributes) do
      if (v:GetId() >= Enums.AttributeId.Buff_Icon_End_Tick0 and v:GetId() <= Enums.AttributeId.Buff_Icon_End_Tick31) then         
        local attribDescriptor = AttributeHelper.AttributeDescriptors[v:GetId()]
   
      if attribDescriptor ~= nil then
        local value = v:GetValueInt32()

          if attribDescriptor:GetDataType() == 0 then
            value = v:GetValueFloat()
          end

          if value > 0 then
            local powerName = AttributeHelper.PowerSNOs[v:GetModifier()]

            if v:GetModifier() == -1 or powerName == nil then
              powerName = ""
            end
          
            table.insert(buffer, {Address = v.Address, AttributeId = v:GetId(), AttributeName = attribDescriptor:GetName(), PowerSNO = v:GetModifier(), PowerName = powerName, Value = value})           
          end
        end
        end       
    end

  return buffer
end

function AttributeHelper.GetBuffCount0Attributes(acd)  
  local buffer = {}

    local attributes = acd:GetAttributes()

    for k,v in pairs(attributes) do
      if v:GetId() == Enums.AttributeId.Buff_Icon_Count0 then         
        local attribDescriptor = AttributeHelper.AttributeDescriptors[v:GetId()]
   
      if attribDescriptor ~= nil then
        local value = v:GetValueInt32()

          if attribDescriptor:GetDataType() == 0 then
            value = v:GetValueFloat()
          end

          if value > 0 then
            local powerName = AttributeHelper.PowerSNOs[v:GetModifier()]

            if v:GetModifier() == -1 or powerName == nil then
              powerName = ""
            end
          
            table.insert(buffer, {Address = v.Address, AttributeId = v:GetId(), AttributeName = attribDescriptor:GetName(), PowerSNO = v:GetModifier(), PowerName = powerName, Value = value})           
          end
        end
        end       
    end

  return buffer
end

function AttributeHelper.GetNoModifierAttributes(acd)	
	local buffer = {}

  	local attributes = acd:GetAttributes()

  	for k,v in pairs(attributes) do  
  		if v:GetModifier() == -1 then		  	
      	local attribDescriptor = AttributeHelper.AttributeDescriptors[v:GetId()]
   
   		if attribDescriptor ~= nil then
   			local value = v:GetValueInt32()

      		if attribDescriptor:GetDataType() == 0 then
      			value = v:GetValueFloat()
      		end

      		if value > 0 then
      			local powerName = AttributeHelper.PowerSNOs[v:GetModifier()]

      			if powerName == nil then
        			powerName = ""
      			end
      	  
        		table.insert(buffer, {AttributeId = v:GetId(), AttributeName = attribDescriptor:GetName(), PowerSNO = v:GetModifier(), PowerName = powerName, Value = value})           
        	end
      	end 
      	end     	
  	end

  return buffer
end

function AttributeHelper.GetModifierAttributes(acd)	
	local buffer = {}

  	local attributes = acd:GetAttributes()

  	for k,v in pairs(attributes) do  
  		if v:GetModifier() ~= -1 then		  	
      	local attribDescriptor = AttributeHelper.AttributeDescriptors[v:GetId()]
   
   		if attribDescriptor ~= nil then
   			local value = v:GetValueInt32()

      		if attribDescriptor:GetDataType() == 0 then
      			value = v:GetValueFloat()
      		end

      		if value > 0 then
      			local powerName = AttributeHelper.PowerSNOs[v:GetModifier()]

      			if powerName == nil then
        			powerName = ""
      			end
      	  
        		table.insert(buffer, {AttributeId = v:GetId(), AttributeName = attribDescriptor:GetName(), PowerSNO = v:GetModifier(), PowerName = powerName, Value = value})           
        	end
      	end 
      	end     	
  	end

  return buffer
end

function AttributeHelper.GetMonsterAffixes(acd)
  local affixes = {}

  for k,v in pairs(AttributeHelper.GetAllAttributes(acd)) do
    if string.find(v.PowerName, "MonsterAffix") ~= nil then      
      table.insert(affixes, v)
    end
  end

  return affixes
end

function AttributeHelper.IsInGreaterRift(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.In_Tiered_Loot_Run_Level, -1) >= 0
end

function AttributeHelper.IsNPC(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Is_NPC, -1) == 1
end

function AttributeHelper.IsUntargetable(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Untargetable, -1) == 1
end

function AttributeHelper.IsPet(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Pet_Type, -1) >= 0
end

function AttributeHelper.HasArcane(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 214594) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 221130) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 221219) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 219671) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 214791) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 450358) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 384426) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 392128) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 384436) ~= 0
end

function AttributeHelper.HasAvenger(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 384426) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 392128) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 384436) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 226292) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 226289) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 384594) ~= 0
end

function AttributeHelper.HasMortar(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 384594) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 384596) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 215756) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 215757) ~= 0 
end

function AttributeHelper.HasDesecrator(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 70874) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 156106) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 221131) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 156105) ~= 0 
end

function AttributeHelper.HasElectrified(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 81420) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 365083) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 109899) ~= 0
end

function AttributeHelper.HasExtraHealth(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 70650) ~= 0 
end

function AttributeHelper.HasFast(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 70849) ~= 0 
end

function AttributeHelper.HasFrozen(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 90144) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 231149) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 231157) ~= 0
end

function AttributeHelper.HasHealthlink(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 71239) ~= 0 
end

function AttributeHelper.HasIllusionist(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 71108) ~= 0
end

function AttributeHelper.IsIllusion(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 264185) ~= 0
end

function AttributeHelper.HasJailer(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 222743) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 222745) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 222744) ~= 0
end

function AttributeHelper.HasKnockback(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 70655) ~= 0 
end

function AttributeHelper.HasMissileDampening(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 91028) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 376860) ~= 0 
end

function AttributeHelper.HasMolten(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 90314) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 109898) ~= 0
end

function AttributeHelper.HasNightmarish(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 247258) ~= 0 
end

function AttributeHelper.HasPlagued(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 90566) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 231115) ~= 0
end

function AttributeHelper.HasReflectsDamage(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 230877) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 285770) ~= 0
end

function AttributeHelper.HasShielding(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 226437) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 226438) ~= 0
end

function AttributeHelper.HasTeleporter(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 155958) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 155959) ~= 0
end

function AttributeHelper.HasThunderstorm(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 336177) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 336178) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 336179) ~= 0
end

function AttributeHelper.HasVortex(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 120306) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 221132) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 120305) ~= 0
end

function AttributeHelper.HasWaller(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 226293) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 226294) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 231117) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 231118) ~= 0 
end

function AttributeHelper.HasFirechains(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 226497) ~= 0 
end

function AttributeHelper.HasOrbiter(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 384570) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 384571) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 343528) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 343527) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 345214) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 345215) ~= 0 
end

function AttributeHelper.HasFrozenPulse(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 384628) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 384630) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 328052) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 332756) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 349748) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 348532) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 332683) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 328053) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 349751) ~= 0 
end

function AttributeHelper.HasPoisonEnchanted(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 384623) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 384624) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 308319) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 308318) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 309247) ~= 0 or
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 309248) ~= 0 
end

function AttributeHelper.HasJuggernaut(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 455436) ~= 0 
end

function AttributeHelper.HasWormhole(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 337106) ~= 0 or 
  AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_0_Visual_Effect_None, 337107) ~= 0 
end

function AttributeHelper.IsLegendaryItem(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Item_Quality_Level, -1) == 9
end

function AttributeHelper.IsWhiteItem(acd)
  local quality = AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Item_Quality_Level, -1)
  return  quality >= 0 and quality <= 2
end

function AttributeHelper.IsGemItem(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Item_Quality_Level, -1) == 1 and AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.GemQuality, -1) > 0
end

function AttributeHelper.IsCraftMaterial(acd)
  return acd:GetActorSNO() == 449044 or
          acd:GetActorSNO() == 137958 or
          acd:GetActorSNO() == 405649   
end

function AttributeHelper.IsRiftKey(acd)
  return acd:GetActorSNO() == 408416
end

function AttributeHelper.IsAncientLegendaryItem(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Ancient_Rank, -1) == 1
end

function AttributeHelper.IsPrimalLegendaryItem(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Ancient_Rank, -1) == 2
end

function AttributeHelper.GetHitpointPercentage(acd)
  return (AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Hitpoints_Cur, -1) / AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Hitpoints_Max_Total, -1)) * 100
end

function AttributeHelper.IsBuffActive(acd, powerSNO, layer)
if layer == nil then
  layer = 0
end

  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Buff_Icon_Count0 + layer, powerSNO) ~= 0
end

function AttributeHelper.GetBuffCount(acd, powerSNO, layer)
if layer == nil then
  layer = 0
end

  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Buff_Icon_Count0 + layer, powerSNO)
end

function AttributeHelper.GetPrimaryResourcePercentage(acd)
  local primaryType = AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Resource_Type_Primary, -1)

  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Resource_Cur, primaryType) / AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Resource_Max_Total, primaryType)
end

function AttributeHelper.IsBuffEndTickPresent(acd, powerSNO)
  for i = Enums.AttributeId.Buff_Icon_End_Tick0, Enums.AttributeId.Buff_Icon_End_Tick31 do
    if AttributeHelper.GetAttributeValue(acd, i, powerSNO) ~= 0 then
      return true
    end
  end

  return false
end

function AttributeHelper.IsBuffStartTickPresent(acd, powerSNO)
  for i = Enums.AttributeId.Buff_Icon_Start_Tick0, Enums.AttributeId.Buff_Icon_Start_Tick31 do
    if AttributeHelper.GetAttributeValue(acd, i, powerSNO) ~= 0 then
      return true
    end
  end

  return false
end

function AttributeHelper.IsBuffCountPresent(acd, powerSNO)
  for i = Enums.AttributeId.Buff_Icon_Count0, Enums.AttributeId.Buff_Icon_Count31 do
    if AttributeHelper.GetAttributeValue(acd, i, powerSNO) ~= 0 then
      return true
    end
  end

  return false
end

function AttributeHelper.IsInTown(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Buff_Icon_Count0, 220304) ~= 0
end

function AttributeHelper.IsTeleporting(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Buff_Icon_Count0, 191590) ~= 0 or
          AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Buff_Icon_Count0, 371141) ~= 0 or
          AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Buff_Icon_Count0, 220318) ~= 0 or
          AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Buff_Icon_Count0, 371139) ~= 0 
end

function AttributeHelper.IsOperatingGizmo(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Buff_Icon_Count0, 30021) ~= 0
end

function AttributeHelper.GetSkillCharges(acd, powerSNO)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Skill_Charges , powerSNO)
end

function AttributeHelper.IsOperated(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Gizmo_Has_Been_Operated , -1) == 1 or AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Gizmo_State, -1) == 1
end

function AttributeHelper.GizmoHasBeenOperated(acd)
  return AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Gizmo_Has_Been_Operated , -1) == 1
end

function AttributeHelper.IsPowerPylon(acd)
  return acd:GetActorSNO() == 330695
end

function AttributeHelper.IsConduitPylon(acd)
  return acd:GetActorSNO() == 330696 or acd:GetActorSNO() == 398654
end

function AttributeHelper.IsChannelingPylon(acd)
  return acd:GetActorSNO() == 330697
end

function AttributeHelper.IsShieldPylon(acd)
  return acd:GetActorSNO() == 330698
end

function AttributeHelper.IsSpeedPylon(acd)
  return acd:GetActorSNO() == 330699
end

function AttributeHelper.IsProtectionShrine(acd)
  return acd:GetActorSNO() == 176074
end

function AttributeHelper.IsEnlightenedShrine(acd)
  return acd:GetActorSNO() == 176075
end

function AttributeHelper.IsFortuneShrine(acd)
  return acd:GetActorSNO() == 176076
end

function AttributeHelper.IsFrenziedShrine(acd)
  return acd:GetActorSNO() == 176077
end

function AttributeHelper.IsFleetingShrine(acd)
  return acd:GetActorSNO() == 260346
end

function AttributeHelper.IsEmpoweredShrine(acd)
  return acd:GetActorSNO() == 260347
end

function AttributeHelper.IsBanditShrine(acd)
  return acd:GetActorSNO() == 269349
end

function AttributeHelper.IsGoblin(acd)
  return acd:GetActorSNO() == 5984 or
          acd:GetActorSNO() == 5985 or
          acd:GetActorSNO() == 5987 or
          acd:GetActorSNO() == 5988 or
          acd:GetActorSNO() == 408655 or
          acd:GetActorSNO() == 408989 or
          acd:GetActorSNO() == 391593 or
          acd:GetActorSNO() == 413289 or
          acd:GetActorSNO() == 410576 or
          acd:GetActorSNO() == 410586 or
          acd:GetActorSNO() == 326803 or
          acd:GetActorSNO() == 408354 or
          acd:GetActorSNO() == 410572 or
          acd:GetActorSNO() == 410574 or
          acd:GetActorSNO() == 429161 
end

function AttributeHelper.IsRiftProgressOrb(acd)
  return acd:GetActorSNO() == 401751 or
          acd:GetActorSNO() == 436807
end

function AttributeHelper.IsPylonSpawnMarker(acd)
  return acd:GetActorSNO() == 428690 
end

function AttributeHelper.IsPoolOfReflection(acd)
  return acd:GetActorSNO() == 373463 
end

function AttributeHelper.IsGrotesque(acd)
  return acd:GetActorSNO() == 3847 or
          acd:GetActorSNO() == 218307 or
          acd:GetActorSNO() == 218308 or
          acd:GetActorSNO() == 365450 or
          acd:GetActorSNO() == 3848 or
          acd:GetActorSNO() == 218405 or
          acd:GetActorSNO() == 3849 or
          acd:GetActorSNO() == 113994 or
          acd:GetActorSNO() == 3850 or
          acd:GetActorSNO() == 195639 or
          acd:GetActorSNO() == 365465 or
          acd:GetActorSNO() == 191592
end

function AttributeHelper.IsGambleItem(acd)
  return acd:GetActorSNO() == 377347 or
          acd:GetActorSNO() == 377345 or
          acd:GetActorSNO() == 377344 or
          acd:GetActorSNO() == 377348 or
          acd:GetActorSNO() == 377346 or
          acd:GetActorSNO() == 472445 or
          acd:GetActorSNO() == 377360 or
          acd:GetActorSNO() == 377359 or
          acd:GetActorSNO() == 377358 or
          acd:GetActorSNO() == 377357 or
          acd:GetActorSNO() == 377356 or
          acd:GetActorSNO() == 377355 or
          acd:GetActorSNO() == 377353 or
          acd:GetActorSNO() == 377352 or
          acd:GetActorSNO() == 377351 or
          acd:GetActorSNO() == 377350 or
          acd:GetActorSNO() == 377349
end