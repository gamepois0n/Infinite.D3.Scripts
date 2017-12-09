TextureViewer = { }
TextureViewer.Files = {}
TextureViewer.SelectedFile = nil
TextureViewer.SelectedFileIndex = 0
TextureViewer.SelectedFileAtlasStrings = {}
TextureViewer.SelectedFileAtlasIndex = 0

function TextureViewer.DrawMainWindow() 
	local valueChanged = false

	ImGui.Begin("Texture Viewer", RadarSettings.EnabledTextureView)  

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