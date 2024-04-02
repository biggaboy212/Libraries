--// Variables
local Version = 5.77
local library =
    loadstring(
    game:HttpGet("https://raw.githubusercontent.com/biggaboy212/Libraries/main/newproj2/xsx%20Lib%20Source.lua")
)()
library.title = "KarpiWare V5 | Early-Access"

local Notif = library:InitNotifications()
Notif:Notify("Loading | Version " .. tostring(Version), 3, "information")

library:Introduction()

local HttpService = game:GetService("HttpService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local mouse = players.LocalPlayer:GetMouse()

print("Version" .. tostring(Version))

local UIS = game:GetService("UserInputService")

local ScriptVariables = {
    CurrentTarget = nil,
    BlatantLock = nil,
    DynamicColour = true,
    TargetSetKey = nil,
    Prediction = 0.150,
    VisualizeTargetSet = true,
    VisualizeTargetSetRadius = 100
}

--// Functions
function ESPTarget(arg1)
    for _, element in pairs(game:GetService("CoreGui"):GetChildren()) do
        if string.find(element.Name, "EspHL") then
            element:Destroy()
            return
        end
    end

    local FillColor = Color3.fromRGB(255, 255, 255)
    local DepthMode = "AlwaysOnTop"
    local FillTransparency = 0.8
    local OutlineColor = Color3.fromRGB(255, 255, 255)
    local OutlineTransparency = 0

    local function Highlight(plr)
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "EspHL" .. HttpService:GenerateGUID()
        Highlight.FillColor = FillColor
        Highlight.DepthMode = DepthMode
        Highlight.FillTransparency = FillTransparency
        Highlight.OutlineColor = OutlineColor
        Highlight.OutlineTransparency = OutlineTransparency
        Highlight.Parent = game:GetService("CoreGui")

        if players:FindFirstChild(plr).Character then
            Highlight.Adornee = players:FindFirstChild(plr).Character
        end

        function Update()
            if
                not players:FindFirstChild(plr) or ScriptVariables.CurrentTarget == nil or
                    ScriptVariables.VisualizeTargetSet == false
             then
                Highlight:Destroy()
            end
            if ScriptVariables.DynamicColour == true or nil then
                Highlight.FillColor =
                    Color3.new(1, 0, 0):Lerp(
                    Color3.new(0, 1, 0),
                    players:FindFirstChild(plr).Character.Humanoid.Health /
                        players:FindFirstChild(plr).Character.Humanoid.MaxHealth
                )
            end
        end
    end

    runService:BindToRenderStep(
        "esp",
        Enum.RenderPriority.Camera.Value,
        function()
            Update()
        end
    )

    Highlight(arg1)
end

if workspace:FindFirstChild("PreESPHL") then
    workspace:FindFirstChild("PreESPHL"):Destroy()
end
local partname = game:GetService("HttpService"):GenerateGUID()

local Highlight = Instance.new("Highlight")
Highlight.FillColor = Color3.fromRGB(255, 255, 255)
Highlight.FillTransparency = 0.6
Highlight.Parent = workspace
Highlight.Name = partname

local highlightPart = Highlight

local function update()
    local Target = mouse.Target
    if workspace:FindFirstChild(partname) then
        workspace[partname]:Destroy()
    end
    local modeltarg
    if Target and Target:FindFirstAncestorOfClass("Model") then
        local model = Target:FindFirstAncestorOfClass("Model")
        if model:FindFirstChild("Humanoid") then
            modeltarg = model
            local part = Target
            if part then
                highlightPart.Adornee = model
            end

            return
        end
    end

    if ScriptVariables.VisualizeTargetSet == true then
        highlightPart.Adornee = modeltarg
    else
        highlightPart:Destroy()
    end
end

game:GetService("RunService").RenderStepped:Connect(
    function()
        update()
    end
)


local Target = mouse.Target
local Model
if Target and Target:FindFirstAncestorOfClass("Model") then
    local model = Target:FindFirstAncestorOfClass("Model")
    if model:FindFirstChild("Humanoid") then
        Model = model      
    end
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local circle = {
    Instance = Drawing.new("Circle"),
    Visible = ScriptVariables.VisualizeTargetSet,
    Radius = ScriptVariables.VisualizeTargetSetRadius,
    Color = Color3.fromRGB(255, 255, 255),
    Thickness = 1,
    Filled = false,
    PlayerInRadius = false
}

circle.Instance.Transparency = 1
circle.Instance.Thickness = circle.Thickness
circle.Instance.Color = circle.Color
circle.Instance.Filled = circle.Filled

function circle:Update()
    if not (self.Instance) then
        return
    end

    self.Instance.Visible = self.Visible
    self.Instance.Radius = self.Radius
    self.Instance.Position = Vector2.new(Mouse.X, Mouse.Y + GuiService:GetGuiInset().Y)
    self.Instance.NumSides = 12

    self.PlayerInRadius = self:CheckPlayerInRadius()

    self.Instance.Thickness = self.PlayerInRadius and 2 or self.Thickness
end

function circle:Destroy()
    self.Instance:Remove()
    self = nil
end

function circle:CheckPlayerInRadius()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local part = player.Character.HumanoidRootPart
            local pos, onScreen = CurrentCamera:WorldToViewportPoint(part.Position)
            local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            if onScreen and distance <= self.Radius then
                return true
            end
        end
    end
    return false
end

function GetClosestTargetPartToCursor(Character)
    local TargetParts = {"Head", "HumanoidRootPart"}
    local ClosestPart = nil
    local ClosestPartPosition = nil
    local ClosestPartOnScreen = false
    local ClosestPartMagnitudeFromMouse = nil
    local ShortestDistance = math.huge

    local function CheckTargetPart(TargetPart)
        if (typeof(TargetPart) == "string") then
            TargetPart = Character:FindFirstChild(TargetPart)
        end
        if not TargetPart then
            return
        end
        local PartPos, OnScreen = CurrentCamera:WorldToViewportPoint(TargetPart.Position)
        local GuiInset = GuiService:GetGuiInset(GuiService)
        local Magnitude = (Vector2.new(PartPos.X, PartPos.Y - GuiInset.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
        if Magnitude < ShortestDistance then
            ClosestPart = TargetPart
            ClosestPartPosition = PartPos
            ClosestPartOnScreen = OnScreen
            ClosestPartMagnitudeFromMouse = Magnitude
            ShortestDistance = Magnitude
        end
    end

    for _, TargetPartName in ipairs(TargetParts) do
        CheckTargetPart(TargetPartName)
    end

    return ClosestPart, ClosestPartPosition, ClosestPartOnScreen, ClosestPartMagnitudeFromMouse
end

function GetClosestPlayerToCursor()
    local ClosestPlayer = nil
    local ShortestDistance = math.huge

    for _, Player in ipairs(Players:GetPlayers()) do
        local Character = Player.Character
        if Character then
            local TargetPart, _, _, Magnitude = GetClosestTargetPartToCursor(Character)
            if TargetPart then
                if circle.Radius > Magnitude and Magnitude < ShortestDistance then
                    ClosestPlayer = Player
                    ShortestDistance = Magnitude
                end
            end
        end
    end

    return ClosestPlayer
end

function SetClosest()
    ScriptVariables.CurrentTarget = nil
    local ClosestPlayer = GetClosestPlayerToCursor()
    if ScriptVariables.CurrentTarget == ClosestPlayer.Name then
        ScriptVariables.CurrentTarget = nil
        Notif:Notify("Unset Target", 3, "information")
    else
        ScriptVariables.CurrentTarget = ClosestPlayer.Name
        ESPTarget(ClosestPlayer.Name)
        Notif:Notify("Target Set: " .. ScriptVariables.CurrentTarget, 3, "information")
    end
end

UserInputService.InputBegan:Connect(
    function(input, isProcessed)
        if not isProcessed and input.KeyCode == Enum.KeyCode[ScriptVariables.TargetSetKey] then
            SetClosest()
        end
    end
)

Heartbeat:Connect(
    function()
        circle:Update()
    end
)

game:GetService("RunService").RenderStepped:Connect(
    function()
        circle.Instance.Radius = ScriptVariables.VisualizeTargetSetRadius
        circle.Instance.Visible = ScriptVariables.VisualizeTargetSet

        if ScriptVariables.BlatantLock == true then
            local Workspace = game:GetService("Workspace")
            local Players = game:GetService("Players")

            function NotDown()
                local Character = Players.LocalPlayer.Character

                if
                    (Character:WaitForChild("BodyEffects")["K.O"].Value or
                        Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil)
                 then
                    return false
                end
                return true
            end

            if NotDown() then
                local find = players:FindFirstChild(ScriptVariables.CurrentTarget)
                local Hit = find.Character.HumanoidRootPart
                Workspace.CurrentCamera.CFrame = CFrame.lookAt(Workspace.CurrentCamera.CFrame.Position, Hit.Position)
            end
        elseif ScriptVariables.BlatantLock == false or ScriptVariables.CurrentTarget == nil then
        -- blank for now
        end
    end
)

--// Library Startup
task.wait(1)
local Init = library:Init()
--
-- Tabs
local Combat = Init:NewTab("Combat")
local CombatSection = Combat:NewSection("Combat")
local Movement = Init:NewTab("Movement")
local MovementSection = Movement:NewSection("Movement")
local Visuals = Init:NewTab("Visuals")
local VisualsSection = Visuals:NewSection("Visuals")
local Misc = Init:NewTab("Misc")
local MiscSection = Misc:NewSection("Misc")
local Settings = Init:NewTab("Settings")
local SettingsSection = Settings:NewSection("Settings")

--// Elements
local SetTarget =
    Combat:NewKeybind(
    "Set Target",
    Enum.KeyCode.E,
    function(input)
        ScriptVariables.TargetSetKey = input
    end
)

local VisualizeTargetSet =
    Combat:NewToggle(
    "Visualize Target Set",
    true,
    function(value)
        if value then
            ScriptVariables.VisualizeTargetSet = true
        else
            ScriptVariables.VisualizeTargetSet = false
        end
    end
)

local FOVRadius = Combat:NewSlider("FOV Radius", "", true, "/", {min = 1, max = 1000, default = 100}, function(value)
    ScriptVariables.VisualizeTargetSetRadius = value
end)

local BlatantLock =
    Combat:NewToggle(
    "Lock [Target]",
    false,
    function(value)
        if value then
            ScriptVariables.BlatantLock = true
            Notif:Notify("Enabled Lock", 3, "information")
        else
            ScriptVariables.BlatantLock = false
            Notif:Notify("Disabled Lock", 3, "information")
        end
    end
):AddKeybind(Enum.KeyCode.T)

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
