local TweenService = game:GetService("TweenService")
--
local function Update(textBox)
	local parentFrame = textBox.Parent
	local textBounds = textBox.TextBounds

	local newFrameSize = UDim2.new(0, textBounds.X + 16, 0, 24)

	TweenService:Create(parentFrame, TweenInfo.new(0, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = newFrameSize}):Play()
	TweenService:Create(textBox, TweenInfo.new(0, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)}):Play()
end

script.Parent:GetPropertyChangedSignal("Text"):Connect(function()
	Update(script.Parent)
end)
