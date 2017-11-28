RadarSettings = { }

function RadarSettings.DrawMainWindow()  
  ImGui.Begin("Radar Settings", true)    
    --[[if ImGui.Button("Save settings", ImVec2(ImGui.GetContentRegionAvailWidth() / 2, 20)) then
		RadarSettings.SaveSettings()
		print("Settings saved")
	end
	
	if ImGui.CollapsingHeader("Monsters (" .. Radar.Monsters.Count .. ")", "id_settings_monsters", true, false) then
		_, Radar.Settings.Monsters.Enabled = ImGui.Checkbox("Global Enabled##id_settings_monsters_enabled", Radar.Settings.Monsters.Enabled)

		if ImGui.CollapsingHeader("Normal (" .. Radar.Monsters.Normal.Count .. ")", "id_settings_monsters_normal", true, false) then
			_, Radar.Settings.Monsters.Normal.Enabled = ImGui.Checkbox("Enabled##id_settings_monsters_normal_enabled", Radar.Settings.Monsters.Normal.Enabled)
			
			_, Radar.Settings.Monsters.Normal.Radius = ImGui.Checkbox("Use Radius##id_settings_monsters_normal_radius", Radar.Settings.Monsters.Normal.Radius)
			ImGui.SameLine()
			_, Radar.Settings.Monsters.Normal.CollisionRadius = ImGui.Checkbox("Use CollisionRadius##id_settings_monsters_normal_collisionradius", Radar.Settings.Monsters.Normal.CollisionRadius)
			ImGui.SameLine()
			_, Radar.Settings.Monsters.Normal.BottomRadius = ImGui.Checkbox("Use BottomRadius##id_settings_monsters_normal_bottomradius", Radar.Settings.Monsters.Normal.BottomRadius)
			
			_, Radar.Settings.Monsters.Normal.CustomRadius = ImGui.Checkbox("Use CustomRadius##id_settings_monsters_normal_customradius", Radar.Settings.Monsters.Normal.CustomRadius)

			_, Radar.Settings.Monsters.Normal.CustomRadiusValue = ImGui.SliderFloat("Custom Radius##id_settings_monsters_normal_customradiusvalue", Radar.Settings.Monsters.Normal.CustomRadiusValue, 1, 10)
			_, Radar.Settings.Monsters.Normal.Thickness = ImGui.SliderFloat("Thickness##id_settings_monsters_normal_thickness", Radar.Settings.Monsters.Normal.Thickness, 1, 5)
			_, Radar.Settings.Monsters.Normal.Fill = ImGui.Checkbox("Fill##id_settings_monsters_normal_fill", Radar.Settings.Monsters.Normal.Fill)
			
			ImGui.ColorButton("Color##id_settings_monsters_normal_color", ImVec4(Radar.Settings.Monsters.Normal.Color.R/255, Radar.Settings.Monsters.Normal.Color.G/255, Radar.Settings.Monsters.Normal.Color.B/255, Radar.Settings.Monsters.Normal.Color.A/255), ImVec2(20,20))

			_, Radar.Settings.Monsters.Normal.Color.A = ImGui.SliderInt("A##id_settings_monsters_normal_color_a", Radar.Settings.Monsters.Normal.Color.A, 0, 255)
			_, Radar.Settings.Monsters.Normal.Color.R = ImGui.SliderInt("R##id_settings_monsters_normal_color_r", Radar.Settings.Monsters.Normal.Color.R, 0, 255)
			_, Radar.Settings.Monsters.Normal.Color.G = ImGui.SliderInt("G##id_settings_monsters_normal_color_g", Radar.Settings.Monsters.Normal.Color.G, 0, 255)
			_, Radar.Settings.Monsters.Normal.Color.B = ImGui.SliderInt("B##id_settings_monsters_normal_color_b", Radar.Settings.Monsters.Normal.Color.B, 0, 255)
		end

		if ImGui.CollapsingHeader("Elite (" .. Radar.Monsters.Elite.Count .. ")", "id_settings_monsters_elite", true, false) then
			_, Radar.Settings.Monsters.Elite.Enabled = ImGui.Checkbox("Enabled##id_settings_monsters_elite_enabled", Radar.Settings.Monsters.Elite.Enabled)

			_, Radar.Settings.Monsters.Elite.Radius = ImGui.Checkbox("Use Radius##id_settings_monsters_elite_radius", Radar.Settings.Monsters.Elite.Radius)
			ImGui.SameLine()
			_, Radar.Settings.Monsters.Elite.CollisionRadius = ImGui.Checkbox("Use CollisionRadius##id_settings_monsters_elite_collisionradius", Radar.Settings.Monsters.Elite.CollisionRadius)
			ImGui.SameLine()
			_, Radar.Settings.Monsters.Elite.BottomRadius = ImGui.Checkbox("Use BottomRadius##id_settings_monsters_elite_bottomradius", Radar.Settings.Monsters.Elite.BottomRadius)
			
			_, Radar.Settings.Monsters.Elite.CustomRadius = ImGui.Checkbox("Use CustomRadius##id_settings_monsters_elite_customradius", Radar.Settings.Monsters.Elite.CustomRadius)

			_, Radar.Settings.Monsters.Elite.CustomRadiusValue = ImGui.SliderFloat("Custom Radius##id_settings_monsters_elite_customradiusvalue", Radar.Settings.Monsters.Elite.CustomRadiusValue, 1, 10)
			_, Radar.Settings.Monsters.Elite.Thickness = ImGui.SliderFloat("Thickness##id_settings_monsters_elite_thickness", Radar.Settings.Monsters.Elite.Thickness, 1, 5)
			_, Radar.Settings.Monsters.Elite.Fill = ImGui.Checkbox("Fill##id_settings_monsters_elite_fill", Radar.Settings.Monsters.Elite.Fill)

			ImGui.ColorButton("Color##id_settings_monsters_elite_color", ImVec4(Radar.Settings.Monsters.Elite.Color.R/255, Radar.Settings.Monsters.Elite.Color.G/255, Radar.Settings.Monsters.Elite.Color.B/255, Radar.Settings.Monsters.Elite.Color.A/255), ImVec2(20,20))

			_, Radar.Settings.Monsters.Elite.Color.A = ImGui.SliderInt("A##id_settings_monsters_elite_color_a", Radar.Settings.Monsters.Elite.Color.A, 0, 255)
			_, Radar.Settings.Monsters.Elite.Color.R = ImGui.SliderInt("R##id_settings_monsters_elite_color_r", Radar.Settings.Monsters.Elite.Color.R, 0, 255)
			_, Radar.Settings.Monsters.Elite.Color.G = ImGui.SliderInt("G##id_settings_monsters_elite_color_g", Radar.Settings.Monsters.Elite.Color.G, 0, 255)
			_, Radar.Settings.Monsters.Elite.Color.B = ImGui.SliderInt("B##id_settings_monsters_elite_color_b", Radar.Settings.Monsters.Elite.Color.B, 0, 255)
		end

		if ImGui.CollapsingHeader("Boss (" .. Radar.Monsters.Boss.Count .. ")", "id_settings_monsters_boss", true, false) then
			_, Radar.Settings.Monsters.Boss.Enabled = ImGui.Checkbox("Enabled##id_settings_monsters_boss_enabled", Radar.Settings.Monsters.Boss.Enabled)

			_, Radar.Settings.Monsters.Boss.Radius = ImGui.Checkbox("Use Radius##id_settings_monsters_boss_radius", Radar.Settings.Monsters.Boss.Radius)
			ImGui.SameLine()
			_, Radar.Settings.Monsters.Boss.CollisionRadius = ImGui.Checkbox("Use CollisionRadius##id_settings_monsters_boss_collisionradius", Radar.Settings.Monsters.Boss.CollisionRadius)
			ImGui.SameLine()
			_, Radar.Settings.Monsters.Boss.BottomRadius = ImGui.Checkbox("Use BottomRadius##id_settings_monsters_boss_bottomradius", Radar.Settings.Monsters.Boss.BottomRadius)
			
			_, Radar.Settings.Monsters.Boss.CustomRadius = ImGui.Checkbox("Use CustomRadius##id_settings_monsters_boss_customradius", Radar.Settings.Monsters.Boss.CustomRadius)

			_, Radar.Settings.Monsters.Boss.CustomRadiusValue = ImGui.SliderFloat("Custom Radius##id_settings_monsters_boss_customradiusvalue", Radar.Settings.Monsters.Boss.CustomRadiusValue, 1, 10)
			_, Radar.Settings.Monsters.Boss.Thickness = ImGui.SliderFloat("Thickness##id_settings_monsters_boss_thickness", Radar.Settings.Monsters.Boss.Thickness, 1, 5)
			_, Radar.Settings.Monsters.Boss.Fill = ImGui.Checkbox("Fill##id_settings_monsters_boss_fill", Radar.Settings.Monsters.Boss.Fill)

			ImGui.ColorButton("Color##id_settings_monsters_boss_color", ImVec4(Radar.Settings.Monsters.Boss.Color.R/255, Radar.Settings.Monsters.Boss.Color.G/255, Radar.Settings.Monsters.Boss.Color.B/255, Radar.Settings.Monsters.Boss.Color.A/255), ImVec2(20,20))

			_, Radar.Settings.Monsters.Boss.Color.A = ImGui.SliderInt("A##id_settings_monsters_boss_color_a", Radar.Settings.Monsters.Boss.Color.A, 0, 255)
			_, Radar.Settings.Monsters.Boss.Color.R = ImGui.SliderInt("R##id_settings_monsters_boss_color_r", Radar.Settings.Monsters.Boss.Color.R, 0, 255)
			_, Radar.Settings.Monsters.Boss.Color.G = ImGui.SliderInt("G##id_settings_monsters_boss_color_g", Radar.Settings.Monsters.Boss.Color.G, 0, 255)
			_, Radar.Settings.Monsters.Boss.Color.B = ImGui.SliderInt("B##id_settings_monsters_boss_color_b", Radar.Settings.Monsters.Boss.Color.B, 0, 255)
		end
	end

	if ImGui.CollapsingHeader("Players (" .. Radar.Players.Count .. ")", "id_settings_players", true, false) then
		_, Radar.Settings.Players.Enabled = ImGui.Checkbox("Enabled##id_settings_players_enabled", Radar.Settings.Players.Enabled)

		_, Radar.Settings.Players.Radius = ImGui.Checkbox("Use Radius##id_settings_players_radius", Radar.Settings.Players.Radius)
		ImGui.SameLine()
		_, Radar.Settings.Players.CollisionRadius = ImGui.Checkbox("Use CollisionRadius##id_settings_players_collisionradius", Radar.Settings.Players.CollisionRadius)
		ImGui.SameLine()
		_, Radar.Settings.Players.BottomRadius = ImGui.Checkbox("Use BottomRadius##id_settings_players_bottomradius", Radar.Settings.Players.BottomRadius)
			
		_, Radar.Settings.Players.CustomRadius = ImGui.Checkbox("Use CustomRadius##id_settings_players_customradius", Radar.Settings.Players.CustomRadius)

		_, Radar.Settings.Players.CustomRadiusValue = ImGui.SliderFloat("Custom Radius##id_settings_players_customradiusvalue", Radar.Settings.Players.CustomRadiusValue, 1, 10)
		_, Radar.Settings.Players.Thickness = ImGui.SliderFloat("Thickness##id_settings_players_thickness", Radar.Settings.Players.Thickness, 1, 5)
		_, Radar.Settings.Players.Fill = ImGui.Checkbox("Fill##id_settings_players_fill", Radar.Settings.Players.Fill)

		ImGui.ColorButton("Color##id_settings_players_color", ImVec4(Radar.Settings.Players.Color.R/255, Radar.Settings.Players.Color.G/255, Radar.Settings.Players.Color.B/255, Radar.Settings.Players.Color.A/255), ImVec2(20,20))

		_, Radar.Settings.Players.Color.A = ImGui.SliderInt("A##id_settings_players_color_a", Radar.Settings.Players.Color.A, 0, 255)
		_, Radar.Settings.Players.Color.R = ImGui.SliderInt("R##id_settings_players_color_r", Radar.Settings.Players.Color.R, 0, 255)
		_, Radar.Settings.Players.Color.G = ImGui.SliderInt("G##id_settings_players_color_g", Radar.Settings.Players.Color.G, 0, 255)
		_, Radar.Settings.Players.Color.B = ImGui.SliderInt("B##id_settings_players_color_b", Radar.Settings.Players.Color.B, 0, 255)
	end

	if ImGui.CollapsingHeader("Gizmos (" .. Radar.Gizmos.Count .. ")", "id_settings_gizmos", true, false) then
		_, Radar.Settings.Gizmos.Enabled = ImGui.Checkbox("Enabled##id_settings_gizmos_enabled", Radar.Settings.Gizmos.Enabled)

		_, Radar.Settings.Gizmos.Radius = ImGui.Checkbox("Use Radius##id_settings_gizmos_radius", Radar.Settings.Gizmos.Radius)
		ImGui.SameLine()
		_, Radar.Settings.Gizmos.CollisionRadius = ImGui.Checkbox("Use CollisionRadius##id_settings_gizmos_collisionradius", Radar.Settings.Gizmos.CollisionRadius)
		ImGui.SameLine()
		_, Radar.Settings.Gizmos.BottomRadius = ImGui.Checkbox("Use BottomRadius##id_settings_gizmos_bottomradius", Radar.Settings.Gizmos.BottomRadius)
			
		_, Radar.Settings.Gizmos.CustomRadius = ImGui.Checkbox("Use CustomRadius##id_settings_gizmos_customradius", Radar.Settings.Gizmos.CustomRadius)

		_, Radar.Settings.Gizmos.CustomRadiusValue = ImGui.SliderFloat("Custom Radius##id_settings_gizmos_customradiusvalue", Radar.Settings.Gizmos.CustomRadiusValue, 1, 10)
		_, Radar.Settings.Gizmos.Thickness = ImGui.SliderFloat("Thickness##id_settings_gizmos_thickness", Radar.Settings.Gizmos.Thickness, 1, 5)
		_, Radar.Settings.Gizmos.Fill = ImGui.Checkbox("Fill##id_settings_gizmos_fill", Radar.Settings.Gizmos.Fill)

		ImGui.ColorButton("Color##id_settings_gizmos_color", ImVec4(Radar.Settings.Gizmos.Color.R/255, Radar.Settings.Gizmos.Color.G/255, Radar.Settings.Gizmos.Color.B/255, Radar.Settings.Gizmos.Color.A/255), ImVec2(20,20))

		_, Radar.Settings.Gizmos.Color.A = ImGui.SliderInt("A##id_settings_gizmos_color_a", Radar.Settings.Gizmos.Color.A, 0, 255)
		_, Radar.Settings.Gizmos.Color.R = ImGui.SliderInt("R##id_settings_gizmos_color_r", Radar.Settings.Gizmos.Color.R, 0, 255)
		_, Radar.Settings.Gizmos.Color.G = ImGui.SliderInt("G##id_settings_gizmos_color_g", Radar.Settings.Gizmos.Color.G, 0, 255)
		_, Radar.Settings.Gizmos.Color.B = ImGui.SliderInt("B##id_settings_gizmos_color_b", Radar.Settings.Gizmos.Color.B, 0, 255)
	end

	if ImGui.CollapsingHeader("GroundEffects (" .. Radar.GroundEffects.Count .. ")", "id_settings_GroundEffects", true, false) then
		_, Radar.Settings.GroundEffects.Enabled = ImGui.Checkbox("Enabled##id_settings_GroundEffects_enabled", Radar.Settings.GroundEffects.Enabled)

		_, Radar.Settings.GroundEffects.Radius = ImGui.Checkbox("Use Radius##id_settings_GroundEffects_radius", Radar.Settings.GroundEffects.Radius)
		ImGui.SameLine()
		_, Radar.Settings.GroundEffects.CollisionRadius = ImGui.Checkbox("Use CollisionRadius##id_settings_GroundEffects_collisionradius", Radar.Settings.GroundEffects.CollisionRadius)
		ImGui.SameLine()
		_, Radar.Settings.GroundEffects.BottomRadius = ImGui.Checkbox("Use BottomRadius##id_settings_GroundEffects_bottomradius", Radar.Settings.GroundEffects.BottomRadius)
			
		_, Radar.Settings.GroundEffects.CustomRadius = ImGui.Checkbox("Use CustomRadius##id_settings_GroundEffects_customradius", Radar.Settings.GroundEffects.CustomRadius)

		_, Radar.Settings.GroundEffects.CustomRadiusValue = ImGui.SliderFloat("Custom Radius##id_settings_GroundEffects_customradiusvalue", Radar.Settings.GroundEffects.CustomRadiusValue, 1, 10)
		_, Radar.Settings.GroundEffects.Thickness = ImGui.SliderFloat("Thickness##id_settings_GroundEffects_thickness", Radar.Settings.GroundEffects.Thickness, 1, 5)
		_, Radar.Settings.GroundEffects.Fill = ImGui.Checkbox("Fill##id_settings_GroundEffects_fill", Radar.Settings.GroundEffects.Fill)

		ImGui.ColorButton("Color##id_settings_GroundEffects_color", ImVec4(Radar.Settings.GroundEffects.Color.R/255, Radar.Settings.GroundEffects.Color.G/255, Radar.Settings.GroundEffects.Color.B/255, Radar.Settings.GroundEffects.Color.A/255), ImVec2(20,20))

		_, Radar.Settings.GroundEffects.Color.A = ImGui.SliderInt("A##id_settings_GroundEffects_color_a", Radar.Settings.GroundEffects.Color.A, 0, 255)
		_, Radar.Settings.GroundEffects.Color.R = ImGui.SliderInt("R##id_settings_GroundEffects_color_r", Radar.Settings.GroundEffects.Color.R, 0, 255)
		_, Radar.Settings.GroundEffects.Color.G = ImGui.SliderInt("G##id_settings_GroundEffects_color_g", Radar.Settings.GroundEffects.Color.G, 0, 255)
		_, Radar.Settings.GroundEffects.Color.B = ImGui.SliderInt("B##id_settings_GroundEffects_color_b", Radar.Settings.GroundEffects.Color.B, 0, 255)
	end

	if ImGui.CollapsingHeader("Items (" .. Radar.Items.Count .. ")", "id_settings_Items", true, false) then
		_, Radar.Settings.Items.Enabled = ImGui.Checkbox("Enabled##id_settings_Items_enabled", Radar.Settings.Items.Enabled)

		_, Radar.Settings.Items.Radius = ImGui.Checkbox("Use Radius##id_settings_Items_radius", Radar.Settings.Items.Radius)
		ImGui.SameLine()
		_, Radar.Settings.Items.CollisionRadius = ImGui.Checkbox("Use CollisionRadius##id_settings_Items_collisionradius", Radar.Settings.Items.CollisionRadius)
		ImGui.SameLine()
		_, Radar.Settings.Items.BottomRadius = ImGui.Checkbox("Use BottomRadius##id_settings_Items_bottomradius", Radar.Settings.Items.BottomRadius)
			
		_, Radar.Settings.Items.CustomRadius = ImGui.Checkbox("Use CustomRadius##id_settings_Items_customradius", Radar.Settings.Items.CustomRadius)

		_, Radar.Settings.Items.CustomRadiusValue = ImGui.SliderFloat("Custom Radius##id_settings_Items_customradiusvalue", Radar.Settings.Items.CustomRadiusValue, 1, 10)
		_, Radar.Settings.Items.Thickness = ImGui.SliderFloat("Thickness##id_settings_Items_thickness", Radar.Settings.Items.Thickness, 1, 5)
		_, Radar.Settings.Items.Fill = ImGui.Checkbox("Fill##id_settings_Items_fill", Radar.Settings.Items.Fill)

		ImGui.ColorButton("Color##id_settings_Items_color", ImVec4(Radar.Settings.Items.Color.R/255, Radar.Settings.Items.Color.G/255, Radar.Settings.Items.Color.B/255, Radar.Settings.Items.Color.A/255), ImVec2(20,20))

		_, Radar.Settings.Items.Color.A = ImGui.SliderInt("A##id_settings_Items_color_a", Radar.Settings.Items.Color.A, 0, 255)
		_, Radar.Settings.Items.Color.R = ImGui.SliderInt("R##id_settings_Items_color_r", Radar.Settings.Items.Color.R, 0, 255)
		_, Radar.Settings.Items.Color.G = ImGui.SliderInt("G##id_settings_Items_color_g", Radar.Settings.Items.Color.G, 0, 255)
		_, Radar.Settings.Items.Color.B = ImGui.SliderInt("B##id_settings_Items_color_b", Radar.Settings.Items.Color.B, 0, 255)
	end]]--

	--for k,v in pairs(Radar.Settings) do
		--ImGui.Text(type(v) .. " " .. k)
	--end

	for k,v in pairs(Radar.Settings) do
		
	end

  ImGui.End()
end

function RadarSettings.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(Radar.Settings))
end

function RadarSettings.LoadSettings()
    local json = JSON:new()
    Radar.Settings = Settings()
    
    table.merge(Radar.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))
end