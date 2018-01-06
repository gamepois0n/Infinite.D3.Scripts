AutoNPCSettings = { }

function AutoNPCSettings.DrawMainWindow()		
  ImGui.Begin("AutoNPC Settings", true)    

  if ImGui.CollapsingHeader("Gamble", "id_gamble", true, false) then

    for k,v in pairs(AutoNPC.Settings.Gamble) do
      if type(v) == "table" then
        _, v.Enabled = ImGui.Checkbox(k .. "##id_AutoNPC_Gamble_" .. k, v.Enabled)
      end
    end

  end

  if ImGui.CollapsingHeader("Salvage", "id_salvage", true, false) then

    for k,v in pairs(AutoNPC.Settings.Salvage) do
      if type(v) == "table" then
        _, v.Enabled = ImGui.Checkbox(k .. "##id_AutoNPC_Salvage_" .. k, v.Enabled)
      end
    end

  end
  ImGui.End()
end

function AutoNPCSettings.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(AutoNPC.Settings))
end

function AutoNPCSettings.LoadSettings()
    local json = JSON:new()
    AutoNPC.Settings = Settings()
    
    table.merge(AutoNPC.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))
end