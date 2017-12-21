RenderHelper = {}

function RenderHelper.LoadImageFileFromCurrentScriptDirectory(filePath)
	return ImGui.LoadImageTexture(Infinity.Scripting.CurrentScript.Directory .. filePath)
end

function RenderHelper.LoadImageFile(filePath)
	return ImGui.LoadImageTexture(filePath)
end

function RenderHelper.LoadDDSFileFromCurrentScriptDirectory(filePath)
	local texture = ImGui.LoadDDSTexture(Infinity.Scripting.CurrentScript.Directory .. filePath)
	local atlasFile

	for w in string.gmatch(filePath,  "[^.]+") do
   		atlasFile = w .. "_atlas.txt"
   		break	
   	end
   	
	local atlas = RenderHelper.LoadDDSAtlas(atlasFile)
	
	return {Texture = texture, Atlas = atlas}
end

function RenderHelper.LoadDDSFile(filePath)
	return ImGui.LoadDDSTexture(filePath)
end

function RenderHelper.LoadDDSAtlas(filePath)
	local content = Infinity.FileSystem.ReadFile(filePath)
	local atlas = {}

	local index = 0

	for i in string.gmatch(content,  "[^\n]+") do --"[^\r\n]+"
		if index > 0 then
			local words = {}

   			for w in string.gmatch(i,  "(.-)%c") do
   				table.insert(words, w)	
   			end
   			
   			table.insert(atlas, {Name = words[1], A = ImVec2(tonumber(words[2]), tonumber(words[3])), B = ImVec2(tonumber(words[4]), tonumber(words[5])), pA = ImVec2(tonumber(words[6]), tonumber(words[7])), pB = ImVec2(tonumber(words[8]), tonumber(words[9]))})
   		end

   		index = index + 1
	end

	if table.length(atlas) ~= 0 then
		return atlas
	end

	return nil
end

function RenderHelper.GetAtlasIndexByName(atlas, name)
	local index = 1

	for k,v in pairs(atlas) do
		if v.Name == name then
			break
		end

		index = index + 1
	end

	return index
end

function RenderHelper.DrawImage(imageTexture, screenPos, renderSize, originalSize, workingArea_a, workingArea_b)
	if imageTexture == nil then
		return
	end

	local uv_a = ImVec2(0, 0)
	local uv_b = ImVec2(1, 1)
	
	if originalSize ~= nil and workingArea_a ~= nil and workingArea_b ~= nil then
		uv_a = ImVec2(workingArea_a.x / originalSize.x, workingArea_a.y / originalSize.y)
		uv_b = ImVec2(workingArea_b.x / originalSize.x, workingArea_b.y / originalSize.y)
	end
	
	local a = ImVec2(screenPos.x - (renderSize.x / 2), screenPos.y - (renderSize.y / 2))
	local b = ImVec2(screenPos.x + (renderSize.x / 2), screenPos.y + (renderSize.y / 2))

	Infinity.Rendering.DrawImage(imageTexture, a, b, uv_a, uv_b, ImVec4(1.0, 1.0, 1.0, 1.0))
end

function RenderHelper.DrawImageFromDDS(dds, screenPos, renderSize, atlasIndex)
	if dds == nil then
		return
	end
	
	if atlasIndex == nil then
		atlasIndex = 1
	end

	local a = ImVec2(screenPos.x - (renderSize.x / 2), screenPos.y - (renderSize.y / 2))
	local b = ImVec2(screenPos.x + (renderSize.x / 2), screenPos.y + (renderSize.y / 2))

	Infinity.Rendering.DrawImage(dds.Texture, a, b, dds.Atlas[atlasIndex].A, dds.Atlas[atlasIndex].B, ImVec4(1.0, 1.0, 1.0, 1.0))
end

function RenderHelper.ToScreen(pos)
	local screen = Infinity.Rendering.Helpers.WorldToScreen(pos)

	if screen.X == -1 and screen.Y == -1 then
		return nil
	end

	if screen.X < 0 or screen.X > 1920 then
		return nil
	end

	if screen.Y < 0 or screen.Y > 1080 then
		return nil
	end

	return screen
end

function RenderHelper.ToUIControlRectArea(uicontrol, pos)
	local screen = Infinity.Rendering.Helpers.WorldToUIControl(uicontrol, pos)

	if screen.X == -1 and screen.Y == -1 then
		return nil
	end

	return screen
end

function RenderHelper.TransformUIRectToClientRect(uiRect)	
  local rootRect = UIControlHelper.GetUIControlByName("Root"):GetUIRect()
  local clientRect = Infinity.D3.GetClientRect()
  
  local Left = clientRect.Left + (clientRect.Width * ((uiRect.Left - rootRect.Left) / rootRect.Width))
  local Top = clientRect.Top + (clientRect.Height * ((uiRect.Top - rootRect.Top) / rootRect.Height))
  local Width = clientRect.Width * (uiRect.Width / rootRect.Width)
  local Height = clientRect.Height * (uiRect.Height / rootRect.Height)

  return Infinity.D3.UIRect(Left, Top, Left + Width, Top + Height)
end

function RenderHelper.ToMinimap(pos)
	local mmap = UIControlHelper.GetUIControlByName("Root.NormalLayer.map_dialog_mainPage.localmap")

	if not mmap:GetIsVisible() then
	mmap = UIControlHelper.GetUIControlByName("Root.NormalLayer.minimap_dialog_backgroundScreen.minimap_dialog_pve.minimap_pve_main")
	end
	
	local mmapRealPoint = RenderHelper.ToUIControlRectArea(mmap, pos)
	local mmapRealRect = mmap:GetUIRect()
	local mmapClientRect = RenderHelper.TransformUIRectToClientRect(mmap:GetUIRect())
	
	local offsetX = (mmapRealPoint.X - mmapRealRect.Left) / mmapRealRect.Width
	local offsetY = (mmapRealPoint.Y - mmapRealRect.Top) / mmapRealRect.Height

	return Vector2(math.floor(mmapClientRect.Left + (mmapClientRect.Width * offsetX)), math.floor(mmapClientRect.Top + (mmapClientRect.Height * offsetY)))
end

function RenderHelper.GetColorImVec4FromHexColorString(hexColorString)
local a = tonumber(string.sub(hexColorString, 1, 2), 16)
local r = tonumber(string.sub(hexColorString, 3, 4), 16)
local g = tonumber(string.sub(hexColorString, 5, 6), 16)
local b = tonumber(string.sub(hexColorString, 7, 8), 16)

return ImVec4(r / 255, g / 255, b / 255, a / 255)
end

function RenderHelper.DrawWorldTextLabels(labels, startpos, vertical, offsetx, offsety)
	local screen = RenderHelper.ToScreen(startpos)

	if screen == nil then
		return
	end

	if offsetx == nil then
		offsetx = 0
	end

	if offsety == nil then
		offsety = 0
	end

	if vertical == nil then
		vertical = false
	end

	screen = Vector2(screen.X + offsetx, screen.Y + offsety)

	for k,v in pairs(labels) do
		local width = (string.len(v.Text) * 10)
		local height = v.Size
		
		RenderHelper.DrawRect(screen, width + 2, height + 2, v.LabelColor, 1, 0, v.Filled)

		if v.Border then
			RenderHelper.DrawRect(screen, width + 2 + (v.BorderThickness * 2), height + 2 + (v.BorderThickness * 2), v.LabelBorderColor, v.BorderThickness, 2, false)
		end

		Infinity.Rendering.DrawText(v.Text, Vector2(screen.X , screen.Y - (height/2)), height, RenderHelper.GetColorImVec4FromHexColorString(v.TextColor), true)

		if not vertical then
			screen = Vector2(screen.X + (width / 2), screen.Y)

			if v.Border then
				screen = Vector2(screen.X + (width / 2) + (v.BorderThickness * 2), screen.Y)
			end
		else
			screen = Vector2(screen.X, screen.Y + (height / 2))

			if v.Border then
				screen = Vector2(screen.X , screen.Y + (height / 2) + (v.BorderThickness * 2))
			end
		end
	end
end

function RenderHelper.DrawTextLabels(labels, startpos, vertical, offsetx, offsety)	
	if offsetx == nil then
		offsetx = 0
	end

	if offsety == nil then
		offsety = 0
	end

	if vertical == nil then
		vertical = false
	end

	startpos = Vector2(startpos.X + offsetx, startpos.Y + offsety)

	for k,v in pairs(labels) do
		local width = (string.len(v.Text) * 10)
		local height = v.Size
		
		RenderHelper.DrawRect(startpos, width + 2, height + 2, v.LabelColor, 1, 0, v.Filled)

		if v.Border then
			RenderHelper.DrawRect(startpos, width + 2 + (v.BorderThickness * 2), height + 2 + (v.BorderThickness * 2), v.LabelBorderColor, v.BorderThickness, 2, false)
		end

		Infinity.Rendering.DrawText(v.Text, Vector2(startpos.X , startpos.Y - (height/2)), height, RenderHelper.GetColorImVec4FromHexColorString(v.TextColor), true)

		if not vertical then
			startpos = Vector2(startpos.X + (width / 2), startpos.Y)

			if v.Border then
				startpos = Vector2(startpos.X + (width / 2) + (v.BorderThickness * 2), startpos.Y)
			end
		else
			startpos = Vector2(startpos.X, startpos.Y + (height / 2))

			if v.Border then
				startpos = Vector2(startpos.X , startpos.Y + (height / 2) + (v.BorderThickness * 2))
			end
		end
	end
end

function RenderHelper.DrawWorldText(text, size, textColor, startpos, offsetx, offsety)
	local screen = RenderHelper.ToScreen(startpos)

	if screen == nil then
		return
	end

	if offsetx == nil then
		offsetx = 0
	end

	if offsety == nil then
		offsety = 0
	end
	
	screen = Vector2(screen.X + offsetx, screen.Y + offsety)
	
	Infinity.Rendering.DrawText(text, screen, size, RenderHelper.GetColorImVec4FromHexColorString(textColor), true)	
end

function RenderHelper.DrawText(text, size, textColor, startpos, offsetx, offsety)	
	if offsetx == nil then
		offsetx = 0
	end

	if offsety == nil then
		offsety = 0
	end
	
	startpos = Vector2(startpos.X + offsetx, startpos.Y + offsety)
	
	Infinity.Rendering.DrawText(text, startpos, size, RenderHelper.GetColorImVec4FromHexColorString(textColor), true)	
end

function RenderHelper.DrawSquare(center, size, color, thickness, filled)
if filled == nil then
	filled = false
end

Infinity.Rendering.DrawSquare(center, size, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, filled)
end

function RenderHelper.DrawRect(center, width, height, color, thickness, rounding, filled)
if filled == nil then
	filled = false
end

if rounding == nil then
	rounding = 0
end

local a = ImVec2(center.X - (width / 2), center.Y - (height / 2))
local b = ImVec2(center.X + (width / 2), center.Y + (height / 2))

Infinity.Rendering.DrawRect(a, b, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, rounding, filled)
end

function RenderHelper.DrawRectFromAB(a, b, color, thickness, rounding, filled)
if filled == nil then
	filled = false
end

if rounding == nil then
	rounding = 0
end

local A = ImVec2(a.X, a.Y)
local B = ImVec2(b.X, b.Y)

Infinity.Rendering.DrawRect(A, B, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, rounding, filled)
end

function RenderHelper.DrawRectFromA(a, width, height, color, thickness, rounding, filled)
if filled == nil then
	filled = false
end

if rounding == nil then
	rounding = 0
end

local A = ImVec2(a.X, a.Y)
local B = ImVec2(a.X + width, a.Y + height)

Infinity.Rendering.DrawRect(A, B, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, rounding, filled)
end

function RenderHelper.DrawQuad(a, b, c, d, color, thickness, filled)
if filled == nil then
	filled = false
end

Infinity.Rendering.DrawQuad(ImVec2(a.X, a.Y), ImVec2(b.X, b.Y), ImVec2(c.X, c.Y), ImVec2(d.X, d.Y), RenderHelper.GetColorImVec4FromHexColorString(color), thickness, filled)
end

function RenderHelper.DrawCircle(center, size, color, thickness, filled)
if filled == nil then
	filled = false
end

Infinity.Rendering.DrawCircle(center, size, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, filled)
end

function RenderHelper.DrawLine(from, to, color, thickness)
Infinity.Rendering.DrawLine(from, to, RenderHelper.GetColorImVec4FromHexColorString(color), thickness)
end

function RenderHelper.DrawWorldSquare(center, size, color, thickness, filled)
if filled == nil then
	filled = false
end

local pts = {}

local screen = RenderHelper.ToScreen(Vector3(center.X - (size / 2), center.Y, center.Z + (size / 2)))

if screen == nil then
	return
end

table.insert(pts, Vector2(screen.X, screen.Y))
			
screen = RenderHelper.ToScreen(Vector3(center.X - (size / 2), center.Y, center.Z - (size / 2)))

if screen == nil then
	return
end

table.insert(pts, Vector2(screen.X, screen.Y))			
			
screen = RenderHelper.ToScreen(Vector3(center.X + (size / 2), center.Y, center.Z - (size / 2)))

if screen == nil then
	return
end

table.insert(pts, Vector2(screen.X, screen.Y))
			
		
screen = RenderHelper.ToScreen(Vector3(center.X + (size / 2), center.Y, center.Z + (size / 2)))

if screen == nil then
	return
end

table.insert(pts, Vector2(screen.X, screen.Y))			

Infinity.Rendering.DrawWorldSquare(pts, size, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, filled)			
end

function RenderHelper.DrawHitBox(actor, color, thickness)
RenderHelper.DrawWorldBox(actor:GetPosition(), actor:GetBodySize(), RenderHelper.GetColorImVec4FromHexColorString(color), thickness, actor:GetBodyHeight())
end

function RenderHelper.DrawHitBox(actor, color, thickness)
RenderHelper.DrawWorldBox(actor:GetPosition(), actor:GetBodySize(), RenderHelper.GetColorImVec4FromHexColorString(color), thickness, actor:GetBodyHeight())
end

function RenderHelper.DrawWorldBox(center, size, color, thickness, height)
if height == nil then
	height = size
end

local pts = {}

local screen = RenderHelper.ToScreen(Vector3(center.X - (size / 2), center.Y, center.Z + (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

screen = RenderHelper.ToScreen(Vector3(center.X - (size / 2), center.Y, center.Z - (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

screen = RenderHelper.ToScreen(Vector3(center.X + (size / 2), center.Y, center.Z - (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

screen = RenderHelper.ToScreen(Vector3(center.X + (size / 2), center.Y, center.Z + (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

screen = RenderHelper.ToScreen(Vector3(center.X - (size / 2), center.Y + height, center.Z + (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

screen = RenderHelper.ToScreen(Vector3(center.X - (size / 2), center.Y + height, center.Z - (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

screen = RenderHelper.ToScreen(Vector3(center.X + (size / 2), center.Y + height, center.Z - (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

screen = RenderHelper.ToScreen(Vector3(center.X + (size / 2), center.Y + height, center.Z + (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

Infinity.Rendering.DrawWorldBox(pts, size, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, filled, height)			
end

function RenderHelper.DrawWorldCircle(center, size, color, thickness, filled)
if filled == nil then
	filled = false
end

local pts = {}

local segments = 20;
--local angle = 0;
local segmentSize = 360 / segments;

local sCenter = RenderHelper.ToScreen(center)
if sCenter == nil then
	return
end

for angle = 0, 360, segmentSize do
	local x = center.X + (size * math.cos(angle / (180 / math.pi)))
	local y = center.Y + (size * math.sin(angle / (180 / math.pi)))

	local screen = RenderHelper.ToScreen(Vector3(x, y, center.Z))
	if screen == nil then
		return
	end

	table.insert(pts, Vector2(screen.X, screen.Y))

	angle = angle + segmentSize
end						

Infinity.Rendering.DrawWorldCircle(pts, size, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, filled)			
end

function RenderHelper.DrawWorldCircleFilledMulticolor(center, size, colorOutline, colorFill, thickness)
local pts = {}

local segments = 20;
--local angle = 0;
local segmentSize = 360 / segments;

local sCenter = RenderHelper.ToScreen(center)
if sCenter == nil then
	return
end

for angle = 0, 360, segmentSize do
	local x = center.X + (size * math.cos(angle / (180 / math.pi)))
	local y = center.Y + (size * math.sin(angle / (180 / math.pi)))

	local screen = RenderHelper.ToScreen(Vector3(x, y, center.Z))
	if screen == nil then
		return
	end

	table.insert(pts, Vector2(screen.X, screen.Y))

	angle = angle + segmentSize
end						

Infinity.Rendering.DrawWorldCircleFilledMulticolor(pts, size, RenderHelper.GetColorImVec4FromHexColorString(colorOutline), RenderHelper.GetColorImVec4FromHexColorString(colorFill), thickness)			
end

function RenderHelper.DrawWorldTriangleFilledMulticolor(center, size, colorOutline, colorFill, thickness)
local pts = {}

local segmentSize = 360 / 3;

local sCenter = RenderHelper.ToScreen(center)
if sCenter == nil then
	return
end

for angle = 0, 360, segmentSize do
	local x = center.X + (size * math.cos(angle / (180 / math.pi)))
	local y = center.Y + (size * math.sin(angle / (180 / math.pi)))

	local screen = RenderHelper.ToScreen(Vector3(x, y, center.Z))
	if screen == nil then
		return
	end

	table.insert(pts, Vector2(screen.X, screen.Y))

	angle = angle + segmentSize
end						

Infinity.Rendering.DrawWorldCircleFilledMulticolor(pts, size, RenderHelper.GetColorImVec4FromHexColorString(colorOutline), RenderHelper.GetColorImVec4FromHexColorString(colorFill), thickness)			
end

function RenderHelper.DrawWorldSquareFilledMulticolor(center, size, colorOutline, colorFill, thickness)
local pts = {}

local segmentSize = 360 / 4;

local sCenter = RenderHelper.ToScreen(center)
if sCenter == nil then
	return
end

for angle = 0, 360, segmentSize do
	local x = center.X + (size * math.cos(angle / (180 / math.pi)))
	local y = center.Y + (size * math.sin(angle / (180 / math.pi)))

	local screen = RenderHelper.ToScreen(Vector3(x, y, center.Z))
	if screen == nil then
		return
	end

	table.insert(pts, Vector2(screen.X, screen.Y))

	angle = angle + segmentSize
end						

Infinity.Rendering.DrawWorldCircleFilledMulticolor(pts, size, RenderHelper.GetColorImVec4FromHexColorString(colorOutline), RenderHelper.GetColorImVec4FromHexColorString(colorFill), thickness)			
end

function RenderHelper.DrawWorldLine(from, to, color, thickness)
local sFrom = RenderHelper.ToScreen(from)
local sTo = RenderHelper.ToScreen(to)

if sFrom == nil or sTo == nil then
	return
end

Infinity.Rendering.DrawWorldLine(sFrom, sTo, RenderHelper.GetColorImVec4FromHexColorString(color), thickness)
end