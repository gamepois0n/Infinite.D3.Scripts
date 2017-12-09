ImGuiHelper = {}

function ImGuiHelper.Image(texture, size, uv0, uv1, tcol, bcol)
	if uv0 == nil then
		uv0 = ImVec2(0,0)
	end

	if uv1 == nil then
		uv1 = ImVec2(1,1)
	end

	if tcol == nil then
		tcol = ImVec4(1,1,1,1)
	end

	if bcol == nil then
		bcol = ImVec4(0,0,0,0)
	end

	ImGui.Image(texture, size, uv0, uv1, tcol, bcol)
end