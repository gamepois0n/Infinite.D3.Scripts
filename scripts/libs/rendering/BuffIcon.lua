BuffIcon = { }
BuffIcon.__index = BuffIcon

setmetatable(BuffIcon, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function BuffIcon:new(texture, atlasindex, powersno, powerlayer, collector)
  local self = setmetatable({}, BuffIcon)
    
  self.Texture = texture
  self.AtlasIndex = atlasindex
  self.PowerSNO = powersno
  self.PowerLayer = powerlayer

  self.Collector = collector  
  self.ACD = nil
  
  return self  
end

function BuffIcon:GetStackedCount()	
	--[[for k,v in pairs(self.Collector.LocalAttributes.BuffCount) do
		if v.PowerSNO == self.PowerSNO then			
			if v.Value > 1 then
				return v.Value		
			end	
		end
	end
	
	return 0]]--

	return AttributeHelper.GetAttributeValue(self.ACD, Enums.AttributeId.Buff_Icon_Count0 + self.PowerLayer, self.PowerSNO)
end

function BuffIcon:GetEndTick()	
	--[[for k,v in pairs(self.Collector.LocalAttributes.BuffEndTick) do
		if v.PowerSNO == self.PowerSNO then			
			if v.Value > 0 then
				return v.Value		
			end	
		end
	end
	
	return 0]]--

	return AttributeHelper.GetAttributeValue(self.ACD, Enums.AttributeId.Buff_Icon_End_Tick0 + self.PowerLayer, self.PowerSNO)
end

function BuffIcon:Draw(renderPosition, renderSize, acd)
	RenderHelper.DrawImageFromDDS(self.Texture, renderPosition, renderSize, self.AtlasIndex)

	if acd == nil then
		self.ACD = Infinity.D3.GetLocalACD()
	else
		self.ACD = acd
	end

	local count = self:GetStackedCount()
	local endtick = self:GetEndTick()

	if count > 1 then
		RenderHelper.DrawText(tostring(count), math.floor(renderSize.x * 0.35), "FFFFFFFF", Vector2(math.floor(renderPosition.x), math.floor(renderPosition.y)), math.floor(renderSize.x * 0.3), math.floor(renderSize.x * 0.15))
	end
	
	if endtick > 0 then		
		RenderHelper.DrawText(string.format("%.1f", (endtick - self.Collector.CurrentGameTick) / 60) .. "s", math.floor(renderSize.x * 0.3), "FFFFFFFF", Vector2(math.floor(renderPosition.x), math.floor(renderPosition.y)), math.floor(renderSize.x * 0.05) * -1, math.floor(renderSize.y * 0.4) * -1)
	end
end