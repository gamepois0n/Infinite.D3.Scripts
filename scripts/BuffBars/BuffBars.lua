BuffBars = { }
BuffBars.Running = false
BuffBars.Collector = Collector()

BuffBars.Settings = Settings()

function BuffBars.Start()
  local files = Infinity.FileSystem.GetFiles("Images\\*.dds")
if files == nil or table.length(files) == 0 then
  print("No Image folder exists in this ScriptFolder or it contains no .dds Texture files! Please download the seperate Images zip!")
  return
end

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
 
  BuffBars.Collector:Collect(true, false, false, false)
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
    if v.Enabled then      
      BuffBars.DrawBuffBar(k, v)
      end
    end
end

function BuffBars.RenderPartyMemberBuffBars()
  for k, playerdata in pairs(BuffBars.Collector.PlayerData.Others) do
    local portraitUIRect = UIControlHelper.GetPortraitUIRectByIndex(playerdata:GetIndex())

    if portraitUIRect ~= nil then
      portraitUIRect = RenderHelper.TransformUIRectToClientRect(portraitUIRect)

      local startX = portraitUIRect.Right + (portraitUIRect.Width * 1.2) + BuffBars.Settings.PartyMemberBuffBar.OffsetX
      local startY = portraitUIRect.Top + BuffBars.Settings.PartyMemberBuffBar.OffsetY

      local acd = Infinity.D3.GetACDbyACDId(playerdata:GetACDId())

      if acd.Address ~= 0 then
        for k,power in pairs(BuffBarsSettings.PartyMemberBuffBarTextures.Powers) do
          if power.BuffIcon ~= nil and AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Buff_Icon_Count0 + power.BuffIcon.PowerLayer, power.BuffIcon.PowerSNO) ~= 0 then
            power.BuffIcon:Draw(ImVec2(startX, startY), ImVec2(BuffBars.Settings.PartyMemberBuffBar.IconSize, BuffBars.Settings.PartyMemberBuffBar.IconSize), acd)

            startX = startX + BuffBars.Settings.PartyMemberBuffBar.IconSize
          end
        end
      end
    end
  end
end

function BuffBars.OnRenderD2D()
if BuffBars.Collector.ClientRect ~= nil then
  BuffBars.RenderBuffBars()
end

if BuffBars.Collector.PlayerData.OthersCount > 0 then
  BuffBars.RenderPartyMemberBuffBars()
end
end