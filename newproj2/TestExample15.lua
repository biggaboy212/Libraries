--// Variables
local HttpService = game:GetService("HttpService");
local others = game:GetService("Players")
local plr1 = others.LocalPlayer
local character = plr1.Character
local humanoid = character.Humanoid
local ScriptVariables = {
    InvisKillEnabled = false,
    OriginalPosition = nil
}

--// Functions

--// Library Startup
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/biggaboy212/Libraries/main/newproj2/xsx%20Lib%20Source.lua"))()
library.title = "KarpiWare V5 | Early-Access"

local Notif = library:InitNotifications()
Notif:Notify("Loading", 3, "information")

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
Combat:NewKeybind("InvisKill Keybind", Enum.KeyCode.Z, function(key)
    Init:UpdateKeybind(Enum.KeyCode[key])
   if ScriptVariables.InvisKillEnabled then
        local PPname = "[Revolver]"
        local mouse = plr1:GetMouse()
    
        local plr = plr1
        local char = plr.Character
        local hum = char.HumanoidRootPart
        local bp = plr.Backpack
        local mouse = plr:GetMouse()
        mouse.KeyDown:connect(function(key)
        if key == key then
        if mouse.Target then
        ScriptVariables.OriginalPosition = hum.CFrame
        hum.CFrame = CFrame.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z)
            local revolver = bp[PPname] or char[PPname]
            local PPlocation = character:WaitForChild(PPname)
                PPlocation.GripPos = Vector3.new(0, 0, 0)

                character.Humanoid:UnequipTools()

                revolver.Parent = character
                PPlocation:Activate()

                character.Humanoid:UnequipTools()
                hum.CFrame = CFrame.new(ScriptVariables.OriginalPosition)
        end
        end
        end)
   end
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
