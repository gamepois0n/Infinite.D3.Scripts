ImageAnimation = { }
ImageAnimation.__index = ImageAnimation

setmetatable(ImageAnimation, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function ImageAnimation:new(imageTexture, imageSize, renderPosition, renderSize, frameSize, frameCount, fps)
  local self = setmetatable({}, ImageAnimation)
  
  self.ImageTexture = imageTexture
  self.ImageSize = imageSize
  self.RenderPosition = renderPosition
  self.RenderSize = renderSize
  self.FrameSize = frameSize
  self.FPS = fps
  self.Frames = {}
  self.CurrentFrame = 1
  self.LastFrame = frameCount
  self.LastDraw = 0

  if type(self.ImageTexture) == "table" then
  	self:InitDDS()
  else
  	self:Init()
  end  

  return self  
end

function ImageAnimation:Init()
	local currentX = 0
	local currentY = 0

	for i = 0, self.LastFrame, 1 do
		if currentX > self.ImageSize.x then
			currentX = 0
			currentY = currentY + self.FrameSize.x
		end

		table.insert(self.Frames, {a = ImVec2(currentX, currentY), b = ImVec2(currentX + self.FrameSize.x, currentY + self.FrameSize.y)})

		currentX = currentX + self.FrameSize.x
	end
end

function ImageAnimation:InitDDS()
	self.LastFrame = table.length(self.ImageTexture.Atlas)
end

function ImageAnimation:DrawDDS()
	if self.CurrentFrame > self.LastFrame then
		self.CurrentFrame = 1
	end

	RenderHelper.DrawImageFromDDS(self.ImageTexture, self.RenderPosition, self.RenderSize, self.ImageSize, self.CurrentFrame)

	self.LastDraw = Infinity.Win32.GetTickCount()
	self.CurrentFrame = self.CurrentFrame + 1
end

function ImageAnimation:Draw()
	--[[if self.LastDraw + (1000 / self.FPS) >= Infinity.Win32.GetTickCount() then
		return
	end]]--

	if type(self.ImageTexture) == "table" then
		self:DrawDDS()
	else

		if self.CurrentFrame > self.LastFrame then
			self.CurrentFrame = 1
		end

		RenderHelper.DrawImage(self.ImageTexture, self.RenderPosition, self.RenderSize, self.ImageSize, self.Frames[self.CurrentFrame].a, self.Frames[self.CurrentFrame].b)

		self.LastDraw = Infinity.Win32.GetTickCount()
		self.CurrentFrame = self.CurrentFrame + 1
	end
end