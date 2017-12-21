CircleAnimation = { }
CircleAnimation.__index = CircleAnimation

setmetatable(CircleAnimation, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CircleAnimation:new()
  local self = setmetatable({}, CircleAnimation)
  
  self.CurrentFrame = 1
  self.Decrease = false

  return self  
end

function CircleAnimation:DrawPulse(position, radius, color, minimap)
	if self.CurrentFrame >= 256 and not self.Decrease then
		self.Decrease = true
		self.CurrentFrame = 254
	end

	if self.CurrentFrame <= 0 and self.Decrease then
		self.Decrease = false
		self.CurrentFrame = 1
	end

	local frameColor = string.format("%02X", self.CurrentFrame) .. color

	if minimap then
		local mPos = RenderHelper.ToMinimap(position)

		RenderHelper.DrawCircle(mPos, radius, frameColor, 2, true)
		RenderHelper.DrawCircle(mPos, radius, "FF" .. color, 2, false)
	else
		RenderHelper.DrawWorldCircleFilledMulticolor(position, radius, "FF" .. color, frameColor, 2)
	end

	if not self.Decrease then
		self.CurrentFrame = self.CurrentFrame + 4
	else
		self.CurrentFrame = self.CurrentFrame - 4
	end
end