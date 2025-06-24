local execStart = tick() -- *starts timer* okay time to write code

local NVHighlights = {}

local Global = (getgenv and getgenv()) or shared
local Config = Global.SpawnUtilsConfig.NightVision

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local StarterGui = game:GetService("StarterGui")

local Ambient = Config.AmbientColor
local Schizophrenia = Config.Psychopathic

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local --[[friends]] deadBodies = Players:GetFriendsAsync(Player.UserId)

local ids = table.create(1000)
local count = 1

while true do
	for _, item in ipairs(deadBodies:GetCurrentPage()) do
		ids[count] = item.Id
		count += 1
	end

	if deadBodies.IsFinished then
		break
	end

	deadBodies:AdvanceToNextPageAsync()
end

local function Base64_encode(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	
    return ((data:gsub('.', function(x) 
        local r, b = '', x:byte()
        for i = 8, 1, -1 do r = r .. (b % 2^i - b % 2^(i - 1) > 0 and '1' or '0') end
        return r;
    end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
				
        if (#x < 6) then return '' end
        local c = 0
        for i = 1, 6 do c = c + (x:sub(i, i) == '1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end) .. ({ '', '==', '=' })[#data%3+1])
end

local messages = {
	"IT'S ALL YOUR FAULT",
	"WHY DID YOU KILL US?",
	"TAKE THE GOGGLES OFF",
	"MURDERER",
	"FUCK YOU.",
	"YOU'LL PAY FOR WHAT YOU DID",
	"TAKE IT OFF",
	"WE WILL TAKE REVENGE",
	"LOSER",
	"YOU GODDAMN MONSTER.",
	"YOU'RE NOT GETTING AWAY THIS TIME, " .. string.upper(Player.DisplayName) .. "."
}

local function createMsg(prefix)
	starterGui:SetCore("ChatMakeSystemMessage", {
		Text = prefix .. ':', messages[math.random(1, 11)]
		Font = Enum.Font.Montserrat;
		Color = Color3.new(1, 0, 0);
	})
end

local MobileButtons = PlayerGui:WaitForChild("MobileButtonsLocal")
local JumpButtonFrame = MobileButtons:WaitForChild("JumpButtonFrame") -- This has a separate script that uses Math and the Screen's AbsoluteSize to move it to the jump button.

local NVButton = Instance.new("ImageButton", JumpButtonFrame)
	NVButton.Name = "NVButton"
	NVButton.Position = UDim2.new(-3.3, 0, 0, 0) -- This is not offscreen, as its Position is relative to its parent. This should be to the top-left of the jump button.
	NVButton.Size = UDim2.new(1, 0, 1, 0)
	NVButton.BackgroundTransparency = 1
	NVButton.Active = true
	NVButton.Image = "rbxassetid://132894389548973"

local NVE = Instance.new("ColorCorrectionEffect", Lighting)
	NVE.Name = "NVE_1"
	NVE.Enabled = false
	NVE.TintColor = Ambient
	NVE.Contrast = 0.2
	NVE.Saturation = -1
	NVE.Brightness = 0.5

local VignetteGui = Instance.new("ScreenGui", PlayerGui)
	VignetteGui.Name = "VignetteGuiLocal"
	VignetteGui.IgnoreGuiInset = true
	VignetteGui.Enabled = false

local Vignette = Instance.new("ImageLabel", VignetteGui)
	Vignette.Name = "Vignette"
	Vignette.Image = "rbxassetid://113537235654608"
	Vignette.Size = UDim2.new(1, 0, 1, 0)
	Vignette.BackgroundTransparency = 1

local SoundOn = Instance.new("Sound", SoundService)
	SoundOn.Name = "NightVisionOn"
	SoundOn.SoundId = "rbxassetid://376178316"
local SoundOff = Instance.new("Sound", SoundService)
	SoundOff.Name = "NightVisionOff"
	SoundOff.SoundId = "rbxassetid://79003354998655"

local Ping = Instance.new("Sound", SoundService)
	Ping.Name = "Ping"
	Ping.SoundId = "rbxassetid://6011559008"
	Ping.Volume = 0.5
local Reverb = Instance.new("ReverbSoundEffect", Ping)
	Reverb.Name = "Reverb"
	Reverb.DecayTime = 20
	Reverb.DryLevel = 0
	Reverb.WetLevel = 10

local info = TweenInfo.new(4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local nv = false
local function nvtoggle()
	print("Toggled", nv)
	if not nv then
		nv = true
		SoundOn:Play()

		NVButton.Image = "rbxassetid://123382459802673"
		if Config.Vignette then VignetteGui.Enabled = true end
		if Config.ColorCorrection then NVE.Enabled = true end
	else
		nv = false
		SoundOff:Play()

		NVButton.Image = "rbxassetid://132894389548973"
		VignetteGui.Enabled = false
		NVE.Enabled = false
	end
end

local function cl(ch)
	local light = Instance.new("PointLight", ch:WaitForChild("HumanoidRootPart"))
		light.Range = 60
		light.Brightness = 2
		light.Color = Ambient
		light.Shadows = true
		light.Enabled = false

	if light then
		local loop = RunService.RenderStepped:Connect(function()
			light.Enabled = nv

			if not light.Parent then loop:Disconnect() end
		end)
	end
end

local function hl(victim) -- Do not feel emotion for the cattle. They are not people, they are victims. They are food.
	local function onCharacterAdded(char)
	-- Non-blocking wait loop for HRP
		task.spawn(function()
			local hrp = char:FindFirstChild("HumanoidRootPart")
			while not hrp do
				char.ChildAdded:Wait()
				hrp = char:FindFirstChild("HumanoidRootPart")
			end
	
			local Highlight = Instance.new("Highlight", char)
				Highlight.Name = "NV_hl"
				Highlight.FillTransparency = 1
				Highlight.OutlineColor = Ambient
				Highlight.Enabled = false

			if Config.Highlights then
				table.insert(NVHighlights, {Highlight = Highlight})

				RunService.RenderStepped:Connect(function()
					if Highlight then
						Highlight.Enabled = nv
					end
				end)
			end
		end)
	end

	victim.CharacterAdded:Connect(onCharacterAdded)
	
	if victim.Character then
		onCharacterAdded(victim.Character)
	end
end

local function voicesinyourhead(plr)
	local char = plr.Character or plr.Character:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")

	if not char then return end

	local corpse = ids[math.random(1, count)] or Player.UserId
	local corpseName = Players:GetNameFromUserIdAsync(corpse)
	local phantom = Players:CreateHumanoidModelFromUserId(corpse)
		phantom.Name = Base64_encode(corpseName)
		phantom:SetPrimaryPartCFrame(hrp.CFrame)
		phantom:TranslateBy(Vector3.new(5, 0, 5))

	for _, obj in ipairs(phantom:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Transparency = 0.2
			obj.CanCollide = false
			obj.Anchored = true
		end
	end

	local ghostHl = Instance.new("Highlight", phantom)
		ghostHl.Name = "Ghosthighlight"
		ghostHl.FillTransparency = 0.5
		ghostHl.OutlineColor = Color3.new(1, 0, 0)
		ghostHl.FillColor = Color3.new(0, 0, 0)

	local Static = Instance.new("SoundService", )
		Static.Name = "Static"
		Static.SoundId = "rbxassetid://4860560167"
		Static.Volume = 0.35
		Static.Looped = true
		Static.Playing = true

	createMsg(corpseName)

	Debris:AddItem(phantom, math.random(1, 3))
end]]

task.spawn(function()
	while true do
		if nv then
			for _, entry in ipairs(NVHighlights) do
				local hl = entry.Highlight

				if hl and hl.Parent then
					hl.OutlineColor = Color3.fromRGB(255, 100, 100)
					local tween = TweenService:Create(hl, info, {OutlineColor = Ambient})
					tween:Play()

					if math.random() < 0.15 then
						voicesinyourhead(Player)
					end
				end
			end
			Ping:Play()
		end
		task.wait(5)
	end
end)

for _, plr in ipairs(Players:GetPlayers()) do
	if plr ~= Player then
		hl(plr)
	end
end

if Player.Character then
	cl(Player.Character)
end

Player.CharacterAdded:Connect(function(char)
	cl(char)
end)

Players.PlayerAdded:Connect(function(plr)
	if plr ~= Player then
		hl(plr)
	else
		cl(plr.Character or plr.CharacterAdded:Wait())
		plr.CharacterAdded:Connect(cl)
	end
end)

task.wait()

print("connect button click")
NVButton.MouseButton1Click:Connect(nvtoggle)

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.KeypadSeven then
		nvtoggle()
	end
end)

local execEnd = tick() -- *stops timer* okay done :3
print("Loaded in " .. tostring(execEnd-execStart) .. ".") -- Basically this should print the amount of time to took t o load this
print("They're all yours,", Player.Name .. ". :)")
