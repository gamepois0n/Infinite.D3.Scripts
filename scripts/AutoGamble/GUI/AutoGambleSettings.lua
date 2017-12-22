AutoGambleSettings = { }

function AutoGambleSettings.DrawMainWindow()		
  ImGui.Begin("AutoGamble Settings", true)    

  for k,v in pairs(AutoGamble.Settings) do
    if type(v) == "table" then
      _, v.Enabled = ImGui.Checkbox(k .. "##id_autogamble_" .. k, v.Enabled)
    end
  end

  ImGui.End()
end

function AutoGambleSettings.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(AutoGamble.Settings))
end

function AutoGambleSettings.LoadSettings()
    local json = JSON:new()
    AutoGamble.Settings = Settings()
    
    table.merge(AutoGamble.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))
end