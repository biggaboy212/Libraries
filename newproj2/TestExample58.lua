--// Variables
local Version = '5.58'
local HttpService = game:GetService("HttpService")
local runService = game:GetService("RunService");
local players = game:GetService("Players")
local mouse = players.LocalPlayer:GetMouse()

print('Version'..Version)

local UIS = game:GetService("UserInputService")

local ScriptVariables = {
    CurrentTarget = nil,
    BlatantLock = nil,
    DynamicColour = nil,
    TargetSetKey = nil
}

--// Functions
function ESPTarget(arg1)
    local FillColor = Color3.fromRGB(145, 0, 255)
    local DepthMode = "AlwaysOnTop"
    local FillTransparency = 0.5
    local OutlineColor = Color3.fromRGB(255,255,255)
    local OutlineTransparency = 0

    local function Highlight(plr)
        local Highlight = Instance.new("Highlight")
        Highlight.Name = HttpService:GenerateGUID()
        Highlight.FillColor = FillColor
        Highlight.DepthMode = DepthMode
        Highlight.FillTransparency = FillTransparency
        Highlight.OutlineColor = OutlineColor
        Highlight.OutlineTransparency = OutlineTransparency
        Highlight.Parent = game:GetService('CoreGui')

        if players:FindFirstChild(arg1).Character then
            Highlight.Adornee = players:FindFirstChild(arg1).Character
        end

        function Update()
        if not players:FindFirstChild(arg1) then
            Highlight:Destroy()
        end
        if ScriptVariables.DynamicColour == true or nil then
            FillColor = Color3.new(1, 0, 0):Lerp(Color3.new(0, 1, 0), players:FindFirstChild(arg1).Character.Humanoid.Health / players:FindFirstChild(arg1).Character.Humanoid.MaxHealth)
        end

        Highlight.FillColor = FillColor
        Highlight.DepthMode = DepthMode
        Highlight.FillTransparency = FillTransparency
        Highlight.OutlineColor = OutlineColor
        Highlight.OutlineTransparency = OutlineTransparency
    end
end

runService:BindToRenderStep("esp", Enum.RenderPriority.Camera.Value, function()
    Update()
end)

Highlight(arg1)
end

function Start(key)
	local Folder = Instance.new('Folder')
	Folder.Parent = workspace
	local Highlight = Instance.new("Highlight")
	Highlight.FillColor = Color3.fromRGB(255, 255, 255)
	Highlight.FillTransparency = 0.6
	Highlight.Parent = Folder

	local Key = key

	local plrs = game:GetService('Players')
	local hrp = plrs.LocalPlayer.Character:FindFirstChild('HumanoidRootPart')

	local highlightPart = Highlight
	highlightPart.Parent = Folder

	local mouse = plrs.LocalPlayer:GetMouse()
	local userInputService = game:GetService('UserInputService')

	local function update()
		local Target = mouse.Target
		if Target and Target:FindFirstAncestorOfClass("Model") then
			local model = Target:FindFirstAncestorOfClass("Model")
			if model:FindFirstChild("Humanoid") then 

				local part = Target
				if part then
					highlightPart.Parent = part.Parent
				end

				return
			end
		end

		highlightPart.Parent = Folder
	end
	
	game:GetService('RunService').RenderStepped:Connect(function()
		update()
	end)


	local function onKeyPress(input)
		if input.KeyCode == Enum.KeyCode[string.upper(Key)] then
			local Target = mouse.Target
			if Target and Target:FindFirstAncestorOfClass("Model") then
				local model = Target:FindFirstAncestorOfClass("Model")
				if model:FindFirstChild("Humanoid") then
					ESPTarget(model.Name)
				end
			end
		end
	end
	userInputService.InputBegan:Connect(onKeyPress)
end

--// Library Startup
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/biggaboy212/Libraries/main/newproj2/xsx%20Lib%20Source.lua"))()
library.title = "KarpiWare V5 | Early-Access"

local Notif = library:InitNotifications()
Notif:Notify("Loading | Version ".. Version, 3, "information")

library:Introduction()
--
task.wait(1)
local Init = library:Init()
--
-- Tabs
local Combat = Init:NewTab("Combat"); local CombatSection = Combat:NewSection("Combat")
local Movement = Init:NewTab("Movement"); local MovementSection = Movement:NewSection("Movement")
local Visuals = Init:NewTab("Visuals"); local VisualsSection = Visuals:NewSection("Visuals")
local Misc = Init:NewTab("Misc"); local MiscSection = Misc:NewSection("Misc")
local Settings = Init:NewTab("Settings"); local SettingsSection = Settings:NewSection("Settings")

--// Elements
local SetTarget = Combat:NewKeybind("Set Target", Enum.KeyCode.Unknown, function(input)
    mouse.KeyDown:Connect(function(Key)
        if tostring(string.upper(Key)) == tostring(input) then
            ScriptVariables.TargetSetKey = input
           Start(ScriptVariables.TargetSetKey)
        end
    end)
end)

local BlatantLock = Combat:NewKeybind("Blatant Lock", Enum.KeyCode.Unknown, function(input)
    mouse.KeyDown:Connect(function(Key)
        if tostring(string.upper(Key)) == tostring(input) then
           
        end
    end)
end)


--[[
local a1 = Combat:NewButton("Button", function()
    print("1")
end)

local Toggle1 = Tab1:NewToggle("Example toggle", false, function(value)
    local vers = value and "on" or "off"
    print("one " .. vers)
end):AddKeybind(Enum.KeyCode.RightControl)

local Keybind1 = Tab1:NewKeybind("Keybind 1", Enum.KeyCode.RightAlt, function(key)
    Init:UpdateKeybind(Enum.KeyCode[key])
end)

local Textbox1 = Tab1:NewTextbox("Text box 1 [auto scales // small]", "", "1", "all", "medium", true, false, function(val)
    print(val)
end)

local Selector1 = Tab1:NewSelector("Selector 1", "bungie", {"fg", "fge", "fg", "fg"}, function(d)
    print(d)
end)

local Slider1 = Tab1:NewSlider("Slider 1", "", true, "/", {min = 1, max = 100, default = 20}, function(value)
    print(value)
end)
]]
