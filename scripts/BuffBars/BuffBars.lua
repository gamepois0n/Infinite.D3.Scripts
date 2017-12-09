BuffBars = { }
BuffBars.Running = false
BuffBars.Collector = Collector()

BuffBars.Settings = Settings()

function BuffBars.Start()
  BuffBars.Running = true

  BuffBarsSettings.LoadSettings()
  BuffBarsSettings.LoadBarsFromSettings()  
end

function BuffBars.Stop()
  BuffBars.Running = false

  BuffBarsSettings.SaveSettings()
end

function BuffBars.OnPulse()
  if BuffBars.Running == false then
    return
  end   
 
  BuffBars.Collector:Collect(true)
end

function BuffBars.DrawBuffBar(index, buffbar)
  if BuffBarsSettings.BuffBarsTextures[index].Texture ~= nil then
    RenderHelper.DrawImageFromDDS(BuffBarsSettings.BuffBarsTextures[index].Texture, ImVec2(BuffBars.Collector.ClientRect.Width * buffbar.ScreenX, BuffBars.Collector.ClientRect.Height * buffbar.ScreenY), ImVec2(buffbar.ContainerSize, buffbar.ContainerSize), buffbar.ContainerImageAtlasIndex)
  else
    RenderHelper.DrawSquare(Vector2(math.floor(BuffBars.Collector.ClientRect.Width * buffbar.ScreenX), math.floor(BuffBars.Collector.ClientRect.Height * buffbar.ScreenY)), buffbar.ContainerSize, "60000000", 1, true)
  end

  local startX = (BuffBars.Collector.ClientRect.Width * buffbar.ScreenX) + buffbar.ContainerSize
  local startY = BuffBars.Collector.ClientRect.Height * buffbar.ScreenY

  for k,v in pairs(BuffBarsSettings.BuffBarsTextures[index].Powers) do
    if v.BuffIcon ~= nil and AttributeHelper.GetAttributeValue(Infinity.D3.GetLocalACD(), Enums.AttributeId.Buff_Icon_Count0 + buffbar.Powers[k].Layer, buffbar.Powers[k].PowerSNO) ~= 0 then
      if startX > ((BuffBars.Collector.ClientRect.Width * buffbar.ScreenX) + buffbar.ContainerSize) + ((buffbar.LimitX - 1) * buffbar.IconSize) then
        startX = (BuffBars.Collector.ClientRect.Width * buffbar.ScreenX) + buffbar.ContainerSize
        startY = startY + buffbar.IconSize
      end

      if startY > (BuffBars.Collector.ClientRect.Height * buffbar.ScreenY) + ((buffbar.LimitY - 1) * buffbar.IconSize) then
        break
      end

      v.BuffIcon:Draw(ImVec2(startX, startY), ImVec2(buffbar.IconSize, buffbar.IconSize))

      startX = startX + buffbar.IconSize
    end
  end
end

function BuffBars.RenderBuffBars()
  for k,v in pairs(BuffBars.Settings.BuffBars) do      
      BuffBars.DrawBuffBar(k, v)
    end
end

function BuffBars.OnRenderD2D()
if BuffBars.Collector.ClientRect ~= nil then
  BuffBars.RenderBuffBars()
end
end