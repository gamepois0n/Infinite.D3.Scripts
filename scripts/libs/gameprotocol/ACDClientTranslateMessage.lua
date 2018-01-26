ACDClientTranslateMessage = { }
ACDClientTranslateMessage.__index = ACDClientTranslateMessage 

setmetatable(ACDClientTranslateMessage , {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function ACDClientTranslateMessage:new(m_Tick, m_Field1, m_Position, m_Angle, m_Speed, m_Field5, m_AnimationTag, m_Field7)
	local self = setmetatable({}, ACDClientTranslateMessage)

	self.Id = 135
	self.Length = 37

	self.GameBitBuffer = Infinity.D3.Net.GameBitBuffer(self.Length)

	self.GameBitBuffer:WriteInt32(32, self.Length);
	self.GameBitBuffer:WriteInt32(10, self.Id);

	self.GameBitBuffer:WriteInt32(32, m_Tick);
	self.GameBitBuffer:WriteInt32(4, m_Field1);
	self.GameBitBuffer:WriteFloat(m_Position.X);
	self.GameBitBuffer:WriteFloat(m_Position.Y);
	self.GameBitBuffer:WriteFloat(m_Position.Z);
	self.GameBitBuffer:WriteFloat(m_Angle);
	self.GameBitBuffer:WriteFloat(m_Speed);
	self.GameBitBuffer:WriteInt32(32, m_Field5);
	self.GameBitBuffer:WriteInt32(21, m_AnimationTag + 1);

	if m_Field7 ~= nil then
		self.GameBitBuffer:WriteInt32(32, m_Field7);
	else
		self.GameBitBuffer:WriteBufferByte(self.Length - 1, 0x1);
	end	

	return self  
end

function ACDClientTranslateMessage:Send()
	self.GameBitBuffer:Send(self.Length)
end