--// Variables
local Version = '45'
local HttpService = game:GetService("HttpService")
local players = game:GetService("Players")
local mouse = players.LocalPlayer:GetMouse()

print('Version'..Version)

local UIS = game:GetService("UserInputService")

local ScriptVariables = {
    InvisKillEnabled = false,
    OriginalPosition = nil
}

--// Functions

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
local Combat = Init:NewTab("Combat"); local CombatSection = Combat:NewSection("Main")
local Movement = Init:NewTab("Movement"); local MovementSection = Movement:NewSection("Movement")
local Visuals = Init:NewTab("Visuals"); local VisualsSection = Visuals:NewSection("Visuals")
local Misc = Init:NewTab("Misc"); local MiscSection = Misc:NewSection("Misc")
local Settings = Init:NewTab("Settings"); local SettingsSection = Settings:NewSection("Settings")



--// Elements
Combat:NewKeybind("InvisKill Keybind", Enum.KeyCode.Unknown, function(input)
    mouse.KeyDown:Connect(function(Key)
        if tostring(string.upper(Key)) == tostring(input) then
            if mouse.Target then
                local localPlayer = players.LocalPlayer
                local PPname = "[Revolver]"
                local char = localPlayer.Character
                local hum = char:FindFirstChild("HumanoidRootPart")
                local bp = localPlayer.Backpack or localPlayer.Character
                local mouse = localPlayer:GetMouse()

                ScriptVariables.OriginalPosition = hum.CFrame
                hum.CFrame = CFrame.new(mouse.Hit.x, mouse.Hit.y, mouse.Hit.z)
                
                local revolver = bp[PPname] or char[PPname]
                local PPlocation = char:WaitForChild(PPname) or bp:WaitForChild(PPname)
                revolver.Parent = char
                PPlocation:Activate()

                char.Humanoid:UnequipTools()
                            
                hum.CFrame = CFrame.new(ScriptVariables.OriginalPosition)
                print('end')
            end
        end
    end)
end)

Combat:NewToggle("InvisKill V2", false, function(value)
ScriptVariables.InvisKillEnabled = value
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
