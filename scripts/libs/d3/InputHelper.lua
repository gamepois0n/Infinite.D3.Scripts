InputHelper = {}

function InputHelper.IsKeyPressed(keyCode)
	return Infinity.D3.GetKeyState(keyCode) ~= 0
end

function InputHelper.IsSpacePressed()
	return InputHelper.IsKeyPressed(0x20)
end

function InputHelper.IsNumpad0Pressed()
	return InputHelper.IsKeyPressed(0x60)
end

function InputHelper.IsNumpad1Pressed()
	return InputHelper.IsKeyPressed(0x61)
end

function InputHelper.IsNumpad2Pressed()
	return InputHelper.IsKeyPressed(0x62)
end

function InputHelper.IsNumpad3Pressed()
	return InputHelper.IsKeyPressed(0x63)
end

function InputHelper.IsNumpad4Pressed()
	return InputHelper.IsKeyPressed(0x64)
end

function InputHelper.IsNumpad5Pressed()
	return InputHelper.IsKeyPressed(0x65)
end

function InputHelper.IsNumpad6Pressed()
	return InputHelper.IsKeyPressed(0x66)
end

function InputHelper.IsNumpad7Pressed()
	return InputHelper.IsKeyPressed(0x67)
end

function InputHelper.IsNumpad8Pressed()
	return InputHelper.IsKeyPressed(0x68)
end

function InputHelper.IsNumpad9Pressed()
	return InputHelper.IsKeyPressed(0x69)
end