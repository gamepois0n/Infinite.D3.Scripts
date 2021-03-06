BuffBarsSettings = { }
BuffBarsSettings.EnabledTextureView = false

BuffBarsSettings.BuffBarsTextures = {}
BuffBarsSettings.SelectedBuffBar = 1

BuffBarsSettings.PartyMemberBuffBarTextures = {}

BuffBarsSettings.BuffTypes = {"Count", "StartTick", "EndTick"}
BuffBarsSettings.BuffTypesSelectedIndex = 1
BuffBarsSettings.PartyMemberBuffTypesSelectedIndex = 1

BuffBarsSettings.BuffPowers = {}
BuffBarsSettings.BuffPowersLayers = {}
BuffBarsSettings.BuffPowersNames = {}
BuffBarsSettings.PartyMemberBuffPowers = {}
BuffBarsSettings.PartyMemberBuffPowersLayers = {}
BuffBarsSettings.PartyMemberBuffPowersNames = {}
BuffBarsSettings.BuffPowersSelectedIndex = 0
BuffBarsSettings.PartyMemberBuffPowersSelectedIndex = 0

function BuffBarsSettings.DrawMainWindow()  
  ImGui.Begin("BuffBars Settings", true)  
  	
  	--[[if ImGui.Button("Show TextureViewer") then
  		if TextureViewer.Visible then
  			TextureViewer.Visible = false
  		else
  			TextureViewer.Visible = true
  		end
  	end]]--
    
    if ImGui.CollapsingHeader("Local Player", "id_buffbars_local_player", true, false) then

      if ImGui.Button("New##new_buffbar") then
        table.insert(BuffBars.Settings.BuffBars, {Name = "New Buffbar_" .. (table.length(BuffBars.Settings.BuffBars) + 1), ContainerTextureFile = "", ContainerImageAtlasIndex = 0,ContainerSize = 50, IconSize = 40, ScreenX = 0.5, ScreenY = 0.5, LimitX = 10, LimitY = 3, Powers = {}})

        BuffBarsSettings.LoadBarsFromSettings()
      end

      for k,v in pairs(BuffBars.Settings.BuffBars) do      
        BuffBarsSettings.DrawBuffBarEntry(k, v)
      end    
    end

    if ImGui.CollapsingHeader("Party Member", "id_buffbars_party_member", true, false) then
      ImGui.Text("Parameters")
      ImGui.Text(" ")
    
      _, BuffBars.Settings.PartyMemberBuffBar.IconSize = ImGui.SliderInt("IconSize##iconsize_pmbb", BuffBars.Settings.PartyMemberBuffBar.IconSize, 10, 100)
      _, BuffBars.Settings.PartyMemberBuffBar.OffsetX = ImGui.SliderInt("OffsetX##offsetx_pmbb", BuffBars.Settings.PartyMemberBuffBar.OffsetX, 0, 100) 
      _, BuffBars.Settings.PartyMemberBuffBar.OffsetY = ImGui.SliderInt("OffsetY##offsety_pmbb", BuffBars.Settings.PartyMemberBuffBar.OffsetY, 0, 100) 

      ImGui.Text(" ")
      ImGui.Text("Powers")
      ImGui.Text(" ")

      BuffBarsSettings.LoadPartyMemberBuffPowers()

      _, BuffBarsSettings.PartyMemberBuffTypesSelectedIndex = ImGui.Combo("Select Buff Type##buff_power_type_select_pmbb", BuffBarsSettings.PartyMemberBuffTypesSelectedIndex, BuffBarsSettings.BuffTypes)

    valueChanged, BuffBarsSettings.PartyMemberBuffPowersSelectedIndex = ImGui.Combo("Select Active Power##buff_power_select_pmbb", BuffBarsSettings.PartyMemberBuffPowersSelectedIndex, BuffBarsSettings.PartyMemberBuffPowersNames)
    if valueChanged then
      table.insert(BuffBars.Settings.PartyMemberBuffBar.Powers, {TextureFile = "", AtlasIndex = 0, PowerSNO = BuffBarsSettings.PartyMemberBuffPowers[BuffBarsSettings.PartyMemberBuffPowersSelectedIndex].PowerSNO, Layer = BuffBarsSettings.PartyMemberBuffPowersLayers[BuffBarsSettings.PartyMemberBuffPowersSelectedIndex].Layer})

      BuffBarsSettings.LoadBarsFromSettings()
    end

    ImGui.Text(" ")
    ImGui.Text("Selected Powers")
    ImGui.Text(" ")
    
    for k,v in pairs(BuffBars.Settings.PartyMemberBuffBar.Powers) do
      if ImGui.Button("X##delete_" .. k) then
        table.remove(BuffBars.Settings.PartyMemberBuffBar.Powers, k)

        BuffBarsSettings.LoadBarsFromSettings()
      end
      
      ImGui.SameLine()

      ImGui.Text(v.PowerSNO)
      
      ImGui.SameLine()

      ImGui.Text(AttributeHelper.PowerSNOs[v.PowerSNO])
      
      ImGui.SameLine()

      if ImGui.Button("Image##power_image_" .. k) then
        TextureViewer.BuffBarsSettingsPartyMemberBuffBarIndex = 1
        TextureViewer.BuffBarsSettingsPowerIndex = k
      end
      
      if BuffBarsSettings.PartyMemberBuffBarTextures.Powers[k].Texture ~= nil then
        ImGui.SameLine()
        
        ImGuiHelper.Image(BuffBarsSettings.PartyMemberBuffBarTextures.Powers[k].Texture.Texture, ImVec2(22, 22), BuffBarsSettings.PartyMemberBuffBarTextures.Powers[k].Texture.Atlas[BuffBarsSettings.PartyMemberBuffBarTextures.Powers[k].AtlasIndex].A, BuffBarsSettings.PartyMemberBuffBarTextures.Powers[k].Texture.Atlas[BuffBarsSettings.PartyMemberBuffBarTextures.Powers[k].AtlasIndex].B)
      
      end
    end
    end

  ImGui.End()
end

function BuffBarsSettings.DrawBuffBarEntry(index, buffbar)
  local valueChanged = false

  if ImGui.Button("X##delete_buffbar_" .. index) then
    table.remove(BuffBars.Settings.BuffBars, index)

    BuffBarsSettings.LoadBarsFromSettings()
  end

  ImGui.SameLine()

  if ImGui.CollapsingHeader("BuffBar_" .. index, "id_buffbar_" .. index, true, false) then
    if ImGui.Button("Container Image##container_image_" .. index) then
        TextureViewer.BuffBarsSettingsBuffBarIndex = index
        TextureViewer.BuffBarsSettingsPowerIndex = 0
      end
      
      if BuffBarsSettings.BuffBarsTextures[index] ~= nil and BuffBarsSettings.BuffBarsTextures[index].Texture ~= nil then
        ImGui.SameLine()

        ImGuiHelper.Image(BuffBarsSettings.BuffBarsTextures[index].Texture.Texture, ImVec2(22, 22), BuffBarsSettings.BuffBarsTextures[index].Texture.Atlas[BuffBarsSettings.BuffBarsTextures[index].AtlasIndex].A, BuffBarsSettings.BuffBarsTextures[index].Texture.Atlas[BuffBarsSettings.BuffBarsTextures[index].AtlasIndex].B)
      end

    ImGui.Text("Parameters")
    ImGui.Text(" ")

    _, buffbar.Enabled = ImGui.Checkbox("Enabled##name", buffbar.Enabled)
    _, buffbar.Name = ImGui.InputText("Name##name", buffbar.Name)
    _, buffbar.ContainerSize = ImGui.SliderInt("ContainerSize##containersize", buffbar.ContainerSize, 10, 100)
    _, buffbar.IconSize = ImGui.SliderInt("IconSize##iconsize", buffbar.IconSize, 10, 100)
    _, buffbar.ScreenX = ImGui.SliderFloat("ScreenX##screenx", buffbar.ScreenX, 0, 1)
    _, buffbar.ScreenY = ImGui.SliderFloat("ScreenY##screeny", buffbar.ScreenY, 0, 1)
    _, buffbar.LimitX = ImGui.SliderInt("LimitX##limitx", buffbar.LimitX, 1, 25)
    _, buffbar.LimitY = ImGui.SliderInt("LimitY##limity", buffbar.LimitY, 1, 5)

    ImGui.Text(" ")
    ImGui.Text("Powers")
    ImGui.Text(" ")

    BuffBarsSettings.LoadBuffPowers()

    _, BuffBarsSettings.BuffTypesSelectedIndex = ImGui.Combo("Select Buff Type##buff_power_type_select", BuffBarsSettings.BuffTypesSelectedIndex, BuffBarsSettings.BuffTypes)

    valueChanged, BuffBarsSettings.BuffPowersSelectedIndex = ImGui.Combo("Select Active Power##buff_power_select", BuffBarsSettings.BuffPowersSelectedIndex, BuffBarsSettings.BuffPowersNames)
    if valueChanged then
      table.insert(buffbar.Powers, {TextureFile = "", AtlasIndex = 0, PowerSNO = BuffBarsSettings.BuffPowers[BuffBarsSettings.BuffPowersSelectedIndex].PowerSNO, Layer = BuffBarsSettings.BuffPowersLayers[BuffBarsSettings.BuffPowersSelectedIndex].Layer})

      BuffBarsSettings.LoadBarsFromSettings()
    end

    ImGui.Text(" ")
    ImGui.Text("Selected Powers")
    ImGui.Text(" ")

    --ImGui.Columns(4)

    for k,v in pairs(buffbar.Powers) do
      if ImGui.Button("X##delete_" .. k) then
        table.remove(buffbar.Powers, k)

        BuffBarsSettings.LoadBarsFromSettings()
      end

      --ImGui.NextColumn()
      ImGui.SameLine()

      ImGui.Text(v.PowerSNO)

      --ImGui.NextColumn()
      ImGui.SameLine()

      ImGui.Text(AttributeHelper.PowerSNOs[v.PowerSNO])

      --ImGui.NextColumn()
      ImGui.SameLine()

      if ImGui.Button("Image##power_image_" .. k) then
        TextureViewer.BuffBarsSettingsBuffBarIndex = index
        TextureViewer.BuffBarsSettingsPowerIndex = k
      end
      
      if BuffBarsSettings.BuffBarsTextures[index] ~= nil and BuffBarsSettings.BuffBarsTextures[index].Powers[k] ~= nil and BuffBarsSettings.BuffBarsTextures[index].Powers[k].Texture ~= nil then
        ImGui.SameLine()
        
        ImGuiHelper.Image(BuffBarsSettings.BuffBarsTextures[index].Powers[k].Texture.Texture, ImVec2(22, 22), BuffBarsSettings.BuffBarsTextures[index].Powers[k].Texture.Atlas[BuffBarsSettings.BuffBarsTextures[index].Powers[k].AtlasIndex].A, BuffBarsSettings.BuffBarsTextures[index].Powers[k].Texture.Atlas[BuffBarsSettings.BuffBarsTextures[index].Powers[k].AtlasIndex].B)
      --else
        --ImGui.Text(" ")
      end

      --ImGui.NextColumn()
    end
  end
end

function BuffBarsSettings.SaveSettings()
  if table.length(BuffBars.Settings.BuffBars) == 0 then
    BuffBars.Settings.BuffBars = {}
  end

    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(BuffBars.Settings))
end

function BuffBarsSettings.LoadSettings()
    local json = JSON:new()
    BuffBars.Settings = Settings()
    
    table.merge(BuffBars.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))
end

function BuffBarsSettings.LoadBarsFromSettings()
  local barsTex = {}

  for k,v in pairs(BuffBars.Settings.BuffBars) do    
    local powers = {}

    for a,power in pairs(v.Powers) do
      if power.TextureFile ~= "" then
        local tex = RenderHelper.LoadDDSFileFromCurrentScriptDirectory(power.TextureFile)

        table.insert(powers, {Texture = tex, AtlasIndex = power.AtlasIndex, BuffIcon = BuffIcon:new(tex, power.AtlasIndex, power.PowerSNO, power.Layer, BuffBars.Collector)})
      else
        table.insert(powers, {Texture = nil, AtlasIndex = 0, BuffIcon = nil})
      end
    end
    
    local buffbar = {Texture = nil, AtlasIndex = v.ContainerImageAtlasIndex, Powers = powers}

    if v.ContainerTextureFile ~= "" then
      buffbar.Texture = RenderHelper.LoadDDSFileFromCurrentScriptDirectory(v.ContainerTextureFile)
    end

    table.insert(barsTex, buffbar)
  end

  BuffBarsSettings.BuffBarsTextures = barsTex

  
  powers = {}

    for a,power in pairs(BuffBars.Settings.PartyMemberBuffBar.Powers) do
      if power.TextureFile ~= "" then
        local tex = RenderHelper.LoadDDSFileFromCurrentScriptDirectory(power.TextureFile)

        table.insert(powers, {Texture = tex, AtlasIndex = power.AtlasIndex, BuffIcon = BuffIcon:new(tex, power.AtlasIndex, power.PowerSNO, power.Layer, BuffBars.Collector)})
      else
        table.insert(powers, {Texture = nil, AtlasIndex = 0, BuffIcon = nil})
      end
    end    
    
  BuffBarsSettings.PartyMemberBuffBarTextures = {Powers = powers}
end

function BuffBarsSettings.LoadBuffPowers()
  local powers = {}
  local layers = {}
  local powersNames = {}

  local buffLayer = 0

  if BuffBarsSettings.BuffTypesSelectedIndex == 1 then
    for k,v in pairs(BuffBars.Collector.LocalAttributes.BuffCount) do
      buffLayer = v.AttributeId - Enums.AttributeId.Buff_Icon_Count0

      table.insert(powers, v)
      table.insert(layers, {Layer = buffLayer})
      table.insert(powersNames, "Layer: " .. buffLayer .. " SNO: " .. v.PowerSNO .. " Name: " .. v.PowerName .. " Value: " .. v.Value)
    end
  elseif BuffBarsSettings.BuffTypesSelectedIndex == 2 then
    for k,v in pairs(BuffBars.Collector.LocalAttributes.BuffStartTick) do
      buffLayer = v.AttributeId - Enums.AttributeId.Buff_Icon_Start_Tick0

      table.insert(powers, v)
      table.insert(layers, {Layer = buffLayer})
      table.insert(powersNames, "Layer: " .. buffLayer .. " SNO: " .. v.PowerSNO .. " Name: " .. v.PowerName .. " Value: " .. v.Value)
    end
  elseif BuffBarsSettings.BuffTypesSelectedIndex == 3 then
    for k,v in pairs(BuffBars.Collector.LocalAttributes.BuffEndTick) do
      buffLayer = v.AttributeId - Enums.AttributeId.Buff_Icon_End_Tick0

      table.insert(powers, v)
      table.insert(layers, {Layer = buffLayer})
      table.insert(powersNames, "Layer: " .. buffLayer .. " SNO: " .. v.PowerSNO .. " Name: " .. v.PowerName .. " Value: " .. v.Value)
    end
  end

  BuffBarsSettings.BuffPowers = powers
  BuffBarsSettings.BuffPowersLayers = layers
  BuffBarsSettings.BuffPowersNames = powersNames
end

function BuffBarsSettings.LoadPartyMemberBuffPowers()
  local powers = {}
  local layers = {}
  local powersNames = {}

  local buffLayer = 0

  for k, playerdata in pairs(BuffBars.Collector.PlayerData.Others) do

    local acd = Infinity.D3.GetACDbyACDId(playerdata:GetACDId())

    if acd.Address ~= 0 then

      if BuffBarsSettings.PartyMemberBuffTypesSelectedIndex == 1 then
        for k,v in pairs(AttributeHelper.GetAllBuffCountAttributes(acd)) do
          buffLayer = v.AttributeId - Enums.AttributeId.Buff_Icon_Count0
          
          table.insert(powers, v)
          table.insert(layers, {Layer = buffLayer})
          table.insert(powersNames, "Layer: " .. buffLayer .. " SNO: " .. v.PowerSNO .. " Name: " .. v.PowerName .. " Value: " .. v.Value)        
        end
        elseif BuffBarsSettings.PartyMemberBuffTypesSelectedIndex == 2 then
          for k,v in pairs(AttributeHelper.GetAllBuffStartTickAttributes(acd)) do
            buffLayer = v.AttributeId - Enums.AttributeId.Buff_Icon_Start_Tick0

            table.insert(powers, v)
            table.insert(layers, {Layer = buffLayer})
            table.insert(powersNames, "Layer: " .. buffLayer .. " SNO: " .. v.PowerSNO .. " Name: " .. v.PowerName .. " Value: " .. v.Value)
          end
          elseif BuffBarsSettings.PartyMemberBuffTypesSelectedIndex == 3 then
            for k,v in pairs(GetAllBuffEndTickAttributes(acd)) do
              buffLayer = v.AttributeId - Enums.AttributeId.Buff_Icon_End_Tick0

              table.insert(powers, v)
              table.insert(layers, {Layer = buffLayer})
              table.insert(powersNames, "Layer: " .. buffLayer .. " SNO: " .. v.PowerSNO .. " Name: " .. v.PowerName .. " Value: " .. v.Value)
            end
          end
        end
      end

      BuffBarsSettings.PartyMemberBuffPowers = powers
      BuffBarsSettings.PartyMemberBuffPowersLayers = layers
      BuffBarsSettings.PartyMemberBuffPowersNames = powersNames
    end