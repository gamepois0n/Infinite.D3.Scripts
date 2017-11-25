PickitSettings = { }

function PickitSettings.DrawMainWindow()		
  ImGui.Begin("Pickit Settings", true)    

    _, Pickit.Settings.PickupRadius = ImGui.SliderInt("Pickup Radius##id_settings_pickup_radius", Pickit.Settings.PickupRadius, 1, 20)    

    _, Pickit.Settings.Legendary.Normal = ImGui.Checkbox("Pick Legendary.Normal##id_settings_legendary_normal", Pickit.Settings.Legendary.Normal)
    _, Pickit.Settings.Legendary.Ancient = ImGui.Checkbox("Pick Legendary.Ancient##id_settings_legendary_ancient", Pickit.Settings.Legendary.Ancient)
    _, Pickit.Settings.Legendary.Primal = ImGui.Checkbox("Pick Legendary.Primal##id_settings_legendary_primal", Pickit.Settings.Legendary.Primal)
    _, Pickit.Settings.Gem.Enabled = ImGui.Checkbox("Pick Gems##id_settings_gems", Pickit.Settings.Gem.Enabled)
    _, Pickit.Settings.CraftMaterial.Enabled = ImGui.Checkbox("Pick CraftMaterials##id_settings_gems", Pickit.Settings.CraftMaterial.Enabled)
    _, Pickit.Settings.RiftKey.Enabled = ImGui.Checkbox("Pick RiftKeys##id_settings_gems", Pickit.Settings.RiftKey.Enabled)

  ImGui.End()
end

function PickitSettings.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(Pickit.Settings))
end

function PickitSettings.LoadSettings()
    local json = JSON:new()
    Pickit.Settings = Settings()
    
    table.merge(Pickit.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))
end