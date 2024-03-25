local TweenService = game:GetService("TweenService")
--
local SelectionIndicator = script.Parent
local Interact = SelectionIndicator.Parent.Interact
--
Interact.MouseEnter:Connect(function()
	TweenService:Create(SelectionIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {Size = UDim2.new(1, 0,0, 1)}):Play()
end)

Interact.MouseLeave:Connect(function()
	TweenService:Create(SelectionIndicator,  TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0,0, 1)}):Play()
end)

Interact.MouseButton1Down:Connect(function()
	TweenService:Create(SelectionIndicator,  TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.65}):Play()
end)

Interact.MouseButton1Up:Connect(function()
	TweenService:Create(SelectionIndicator,  TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.9}):Play()
end)
