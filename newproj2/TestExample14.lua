local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = library.subs.Wait -- Only returns if the GUI has not been terminated. For 'while Wait() do' loops

local PepsisWorld = library:CreateWindow({
    Name = "Pepsi's World",
    Themeable = false
})

local GeneralTab = PepsisWorld:CreateTab({
    Name = "General"
})
local FarmingSection = GeneralTab:CreateSection({
    Name = "Farming"
})
FarmingSection:AddToggle({
    Name = "EXP Grinder",
    Flag = "FarmingSection_EXPGrinder"
})

local BoardControlSection = GeneralTab:CreateSection({
    Name = "Board Control"
})
MiscSection:AddButton({
    Name = "Repair Board",
    Callback = function()
        print("Fixed")
    end
})
BoardControlSection:AddToggle({
    Name = "No Wear & Tear",
    Flag = "BoardControlSection_NoWearTear"
})
MiscSection:AddKeybind({
    Name = "Test Key",
    Callback = print
})
BoardControlSection:AddSlider({
    Name = "Timeout Extension",
    Flag = "BoardControlSection_CoinDistance",
    Value = 3,
    Min = 0,
    Max = 20,
    Callback = function(Value)
        print(Value)
    end
})

local MiscSection = GeneralTab:CreateSection({
    Name = "Misc",
    Side = "Right"
})
MiscSection:AddToggle({
    Name = "Unlock Gamepasses",
    Flag = "MiscSection_UnlockGamepasses",
    Callback = print
})
MiscSection:AddToggle({
    Name = "Auto Compete",
    Flag = "MiscSection_AutoCompete",
    Callback = print
})
MiscSection:AddToggle({
    Name = "Test Toggle/Key",
    Keybind = {
    Mode = "Dynamic" -- Dynamic means to use the 'hold' method, if the user keeps the button pressed for longer than 0.65 seconds; else use toggle method
    },
    Callback = print
})

local FunSection = GeneralTab:CreateSection({
    Name = "Fun Cosmetics"
})
FunSection:AddToggle({
    Name = "Ragdoll Assumes Flight",
    Flag = "FunSection_AssumesFlight"
})
FunSection:AddToggle({
    Name = "Ragdoll On Player Collision",
    Flag = "FunSection_RagdollOnPlayerCollision"
})
FunSection:AddToggle({
    Name = "Un-Ragdoll When Motionless",
    Flag = "FunSection_UnRagdollWhenMotionless"
})
FunSection:AddToggle({
    Name = "Extend Ragdoll Duration",
    Flag = "FunSection_ExtendRagdollDuration"
})
FunSection:AddSlider({
    Name = "Coin Distance",
    Flag = "FarmingSection_Coin Distance",
    Value = 4,
    Min = 0,
    Max = 60,
    Textbox = true,
    Callback = function(Value)
        print(Value)
    end
})
