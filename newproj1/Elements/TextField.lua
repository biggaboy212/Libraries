-- thx chatgpt for gsub i aint doin allat

local TweenService = game:GetService("TweenService")
--
local AcceptCharacterType = 'All' -- 'All', 'Numbers', 'Letters'
local CharacterLimit = false -- Number or false (Only works with *NUMBERS* character type)
local AddCharacterAtEnd = false -- String or false (Using more than one character is buggy)
--
local function Update(textBox)
	local parentFrame = textBox.Parent
	local textBounds = textBox.TextBounds

	local newFrameSize = UDim2.new(0, textBounds.X + 16, 0, 24)

	TweenService:Create(parentFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = newFrameSize}):Play()
	TweenService:Create(textBox, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)}):Play()

	local newText = textBox.Text

	if AcceptCharacterType == "Numbers" or AcceptCharacterType == "numbers" then
		if CharacterLimit and type(CharacterLimit) == 'number' and CharacterLimit > 0 then
			newText = newText:sub(1, CharacterLimit)
		end
		newText = newText:gsub("[^%-%d.]", "")
	elseif AcceptCharacterType == "Letters" or AcceptCharacterType == "letters" then
		newText = newText:gsub("[^%a]", "")
	end

	if type(AddCharacterAtEnd) == 'string' and AddCharacterAtEnd ~= '' then
		if newText ~= '' and not newText:match(AddCharacterAtEnd .. "$") then
			newText = newText .. AddCharacterAtEnd
		end

		if textBox.Text ~= newText then
			textBox.Text = newText
		end
	end
end

--

script.Parent:GetPropertyChangedSignal("Text"):Connect(function()
	Update(script.Parent)
end)

script.Parent.Parent.Parent.Interact.MouseButton1Click:Connect(function()
	script.Parent:CaptureFocus()
end)

--

if type(AddCharacterAtEnd) == 'string' and AddCharacterAtEnd ~= '' then
	script.Parent.Changed:Connect(function(property)
		if property == "Text" then
			local text = script.Parent.Text
			if text == '' or not text:find("%w") then
				script.Parent.Text = text:gsub(AddCharacterAtEnd, "")
			end
		end
	end)
end
