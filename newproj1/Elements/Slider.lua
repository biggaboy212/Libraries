local TweenService = game:GetService("TweenService")
local Parent = script.Parent
local Interact = Parent.Parent.Interact
local bar = Parent.Bar
local textbox = Parent.Parent.SliderValueFrame.InputBox
local mouse = game:GetService('Players').LocalPlayer:GetMouse()
local sliderSizeX = Parent.AbsoluteSize.X 
local held = false

local maxslide = 200
local minslide = 16
local defaultValue = 150
local showDecimals = {
	Show = false,
	DecimalPlace = 2
}

local defaultSlideValue = (defaultValue - minslide) / (maxslide - minslide)
defaultSlideValue = math.clamp(defaultSlideValue, 0, 1)

bar.Size = UDim2.new(defaultSlideValue, 0, 1, 0)
textbox.Text = tostring(defaultValue)

function Round(Value, DecimalPlace)
	return tonumber(string.format("%."..(DecimalPlace or 0).."f", Value))
end

Interact.MouseButton1Down:Connect(function()
	held = true
	Update()
end)

game:GetService("UserInputService").InputEnded:Connect(function(input, gp)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		held = false
	end
end)

mouse.Move:Connect(function()
	if held then
		Update()
	end
end)


function Update()
	local slideValue = math.clamp((mouse.X - Parent.AbsolutePosition.X) / sliderSizeX, 0, 1)
	bar.Size = UDim2.new(slideValue, 0, 1, 0)
	local value = minslide + (maxslide - minslide) * slideValue
	if showDecimals.Show then
		textbox.Text = tostring(Round(value, showDecimals.DecimalPlace))
	else
		textbox.Text = tostring(math.floor(value))
	end
end
