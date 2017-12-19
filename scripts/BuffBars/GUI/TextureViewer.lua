TextureViewer = { }
TextureViewer.Files = {}
TextureViewer.SelectedFile = nil
TextureViewer.SelectedFileIndex = 0
TextureViewer.SelectedFileAtlasStrings = {}
TextureViewer.SelectedFileAtlasIndex = 0

TextureViewer.BuffBarsSettingsBuffBarIndex = 0
TextureViewer.BuffBarsSettingsPartyMemberBuffBarIndex = 0
TextureViewer.BuffBarsSettingsPowerIndex = 0

TextureViewer.Visible = false

function TextureViewer.DrawMainWindow() 
	local valueChanged = false

	if TextureViewer.BuffBarsSettingsBuffBarIndex ~= 0 or TextureViewer.BuffBarsSettingsPartyMemberBuffBarIndex ~= 0 then
		TextureViewer.Visible = true
	end

	if TextureViewer.Visible == false then
		return
	end

	ImGui.Begin("Texture Viewer")  

	if ImGui.Button("Close##close_tv") then
			TextureViewer.BuffBarsSettingsBuffBarIndex = 0
			TextureViewer.BuffBarsSettingsPartyMemberBuffBarIndex = 0
			TextureViewer.BuffBarsSettingsPowerIndex = 0
			TextureViewer.SelectedFileIndex = 0
			TextureViewer.SelectedFileAtlasIndex = 0
			TextureViewer.SelectedFile = nil
			TextureViewer.Visible = false		
	end

	valueChanged, TextureViewer.SelectedFileIndex = ImGui.Combo("Select DDS File##file_dds_select", TextureViewer.SelectedFileIndex, TextureViewer.Files)

	if valueChanged then
		TextureViewer.SelectedFile = RenderHelper.LoadDDSFileFromCurrentScriptDirectory("\\Images\\" .. TextureViewer.Files[TextureViewer.SelectedFileIndex])

		if TextureViewer.SelectedFileAtlasIndex > table.length(TextureViewer.SelectedFile.Atlas) then
			TextureViewer.SelectedFileAtlasIndex = 0
		end

		TextureViewer.GenerateAtlasStrings()
	end

	if TextureViewer.SelectedFile ~= nil then
		ImGuiHelper.Image(TextureViewer.SelectedFile.Texture, ImVec2(200,200))

		valueChanged, TextureViewer.SelectedFileAtlasIndex = ImGui.Combo("Select Atlas Index##file_dds_atlas_select", TextureViewer.SelectedFileAtlasIndex, TextureViewer.SelectedFileAtlasStrings)

		if TextureViewer.SelectedFileAtlasIndex > 0 then			
			ImGuiHelper.Image(TextureViewer.SelectedFile.Texture, ImVec2(TextureViewer.SelectedFile.Atlas[TextureViewer.SelectedFileAtlasIndex].pB.x - TextureViewer.SelectedFile.Atlas[TextureViewer.SelectedFileAtlasIndex].pA.x, TextureViewer.SelectedFile.Atlas[TextureViewer.SelectedFileAtlasIndex].pB.y - TextureViewer.SelectedFile.Atlas[TextureViewer.SelectedFileAtlasIndex].pA.y), TextureViewer.SelectedFile.Atlas[TextureViewer.SelectedFileAtlasIndex].A, TextureViewer.SelectedFile.Atlas[TextureViewer.SelectedFileAtlasIndex].B)			
		end
	end

	if TextureViewer.BuffBarsSettingsBuffBarIndex ~= 0 and TextureViewer.BuffBarsSettingsPowerIndex ~= 0 and TextureViewer.SelectedFileIndex ~= 0 and TextureViewer.SelectedFileAtlasIndex ~= 0 and TextureViewer.BuffBarsSettingsPartyMemberBuffBarIndex == 0 then
		if ImGui.Button("Export To Selected Power##export_to_buffbarsettings_power") then
			BuffBars.Settings.BuffBars[TextureViewer.BuffBarsSettingsBuffBarIndex].Powers[TextureViewer.BuffBarsSettingsPowerIndex].TextureFile = "\\Images\\" .. TextureViewer.Files[TextureViewer.SelectedFileIndex]
			BuffBars.Settings.BuffBars[TextureViewer.BuffBarsSettingsBuffBarIndex].Powers[TextureViewer.BuffBarsSettingsPowerIndex].AtlasIndex = TextureViewer.SelectedFileAtlasIndex

			TextureViewer.BuffBarsSettingsBuffBarIndex = 0
			TextureViewer.BuffBarsSettingsPowerIndex = 0
			TextureViewer.SelectedFileIndex = 0
			TextureViewer.SelectedFileAtlasIndex = 0
			TextureViewer.SelectedFile = nil
			TextureViewer.Visible = false

			BuffBarsSettings.LoadBarsFromSettings()
		end
	elseif TextureViewer.BuffBarsSettingsBuffBarIndex ~= 0 and TextureViewer.BuffBarsSettingsPowerIndex == 0 and TextureViewer.SelectedFileIndex ~= 0 and TextureViewer.SelectedFileAtlasIndex ~= 0 and TextureViewer.BuffBarsSettingsPartyMemberBuffBarIndex == 0 then
		if ImGui.Button("Export To Selected BuffBar Container##export_to_buffbarsettings_container") then
			BuffBars.Settings.BuffBars[TextureViewer.BuffBarsSettingsBuffBarIndex].ContainerTextureFile = "\\Images\\" .. TextureViewer.Files[TextureViewer.SelectedFileIndex]
			BuffBars.Settings.BuffBars[TextureViewer.BuffBarsSettingsBuffBarIndex].ContainerImageAtlasIndex = TextureViewer.SelectedFileAtlasIndex

			TextureViewer.BuffBarsSettingsBuffBarIndex = 0
			TextureViewer.BuffBarsSettingsPowerIndex = 0
			TextureViewer.SelectedFileIndex = 0
			TextureViewer.SelectedFileAtlasIndex = 0
			TextureViewer.SelectedFile = nil
			TextureViewer.Visible = false

			BuffBarsSettings.LoadBarsFromSettings()
		end
	elseif TextureViewer.BuffBarsSettingsPartyMemberBuffBarIndex ~= 0 and TextureViewer.BuffBarsSettingsBuffBarIndex == 0 and TextureViewer.BuffBarsSettingsPowerIndex ~= 0 and TextureViewer.SelectedFileIndex ~= 0 and TextureViewer.SelectedFileAtlasIndex ~= 0 then
		if ImGui.Button("Export To PartyMember Buffbar##export_to_partymember_buffbarsettings_container") then
			BuffBars.Settings.PartyMemberBuffBar.Powers[TextureViewer.BuffBarsSettingsPowerIndex].TextureFile = "\\Images\\" .. TextureViewer.Files[TextureViewer.SelectedFileIndex]
			BuffBars.Settings.PartyMemberBuffBar.Powers[TextureViewer.BuffBarsSettingsPowerIndex].AtlasIndex = TextureViewer.SelectedFileAtlasIndex

			TextureViewer.BuffBarsSettingsBuffBarIndex = 0
			TextureViewer.BuffBarsSettingsPartyMemberBuffBarIndex = 0
			TextureViewer.BuffBarsSettingsPowerIndex = 0
			TextureViewer.SelectedFileIndex = 0
			TextureViewer.SelectedFileAtlasIndex = 0
			TextureViewer.SelectedFile = nil
			TextureViewer.Visible = false

			BuffBarsSettings.LoadBarsFromSettings()
		end	
	end

	ImGui.End()
end

function TextureViewer.GenerateAtlasStrings()
	local t = {}

	for k,v in pairs(TextureViewer.SelectedFile.Atlas) do
		table.insert(t, v.Name)
	end

	TextureViewer.SelectedFileAtlasStrings = t
end

function TextureViewer.LoadImageFiles()
	TextureViewer.Files = Infinity.FileSystem.GetFiles("Images\\*.dds")	
end

TextureViewer.LoadImageFiles()