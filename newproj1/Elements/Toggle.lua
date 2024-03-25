local Parent = script.Parent
local Toggler = Parent.Parent.Holder.Toggler
local Toggled = Toggler.Background.Toggled
--
local Default = false
local State = Default
--
local AvgTime = 0.3
--
local Debounce = Instance.new("BoolValue")
--
local function ChangeToggleState(state)
	State = state
	if state then
		Toggled:TweenPosition(UDim2.new(0.75, 0, 0.5, 0), "InOut", "Quart", AvgTime, false)
	else
		Toggled:TweenPosition(UDim2.new(0.25, 0, 0.5, 0), "InOut", "Quart", AvgTime, false)
	end
end

ChangeToggleState(Default)

local function Interaction()
	if not Debounce.Value then
		ChangeToggleState(not State)
		Debounce.Value = true
		task.wait(AvgTime)
		Debounce.Value = false
	end
end

Parent.MouseButton1Click:Connect(Interaction)
