--// Made only for animations, not a functional module

local TS = game:GetService('TweenService')
--
local Interact = script.Parent
local Holder = Interact.Parent
local Dropdown = Holder.Parent
local CurrentValue = Dropdown.CurrentOption
--
local Open = false
--
Interact.MouseButton1Click:Connect(function()
	if not Open then
		TS:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 604, 0, 250)}):Play()
		Open = true
	elseif Open then
		TS:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 604, 0, 49)}):Play()
		Open = false
	end
end)

function Update()
	Holder:FindFirstChild('Name').OptionName.Text = CurrentValue.Text
end

Update()

CurrentValue:GetPropertyChangedSignal('Text'):Connect(function()
	Update()
end)
