TextLabelAnimation = { }
TextLabelAnimation.__index = TextLabelAnimation

setmetatable(TextLabelAnimation, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function TextLabelAnimation:new()
  local self = setmetatable({}, TextLabelAnimation)
  
  self.CurrentFrame = 1
  self.Decrease = false

  return self  
end

function TextLabelAnimation:DrawPulse(position, text, textsize, color, textcolor, minimap)
	if self.CurrentFrame >= 256 and not self.Decrease then
		self.Decrease = true
		self.CurrentFrame = 254
	end

	if self.CurrentFrame <= 0 and self.Decrease then
		self.Decrease = false
		self.CurrentFrame = 1
	end

	local frameColor = string.format("%02X", self.CurrentFrame) .. color

	local labels = {}

	if minimap then
		table.insert(labels, {Text = text, Size = textsize, LabelColor = frameColor, LabelBorderColor = "FF000000", TextColor = textcolor, Filled = true, Border = true, BorderThickness = 1})

		RenderHelper.DrawTextLabels(labels, RenderHelper.ToMinimap(position), false, 0, 0)		
	else
		table.insert(labels, {Text = text, Size = textsize, LabelColor = frameColor, LabelBorderColor = "FF000000", TextColor = textcolor, Filled = true, Border = true, BorderThickness = 2})

		RenderHelper.DrawWorldTextLabels(labels, position, false, 0, 0)
	end

	if not self.Decrease then
		self.CurrentFrame = self.CurrentFrame + 4
	else
		self.CurrentFrame = self.CurrentFrame - 4
	end
end