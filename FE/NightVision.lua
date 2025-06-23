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

local Ambient = Config.AmbientColor

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

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

local rootping = Instance.new("Sound")
	rootping.Name = "Ping"
	rootping.SoundId = "rbxassetid://6011559008"
	rootping.Volume = 0.5
local Reverb = Instance.new("ReverbSoundEffect", rootping)
	Reverb.Name = "Reverb"
	Reverb.DecayTime = 15
	Reverb.DryLevel = 0
	Reverb.WetLevel = 10

local info = TweenInfo.new(4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local function safeWaitForChild(parent, childName, timeout)
	local t = 0
	timeout = timeout or 5 -- seconds max to wait
	while t < timeout do
		local child = parent:FindFirstChild(childName)
		if child then return child end
		t += task.wait()
	end
	return nil
end

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

local function hl(victim) -- Do not feel emotion for the cattle. They are not people, they are victims. They are food. They're all yours, Player.Name.
	local function onCharacterAdded(char)
		local hrp = safeWaitForChild(char, "HumanoidRootPart")
		if not hrp then return end

		local Highlight = Instance.new("Highlight", char)
			Highlight.Name = "NV_hl"
			Highlight.FillTransparency = 1
			Highlight.OutlineColor = Ambient
			Highlight.Enabled = false

		local Ping = rootping:Clone()
			Ping.Parent = hrp

		if Config.Highlights then
			table.insert(NVHighlights, {Highlight = Highlight, Ping = Ping})

			RunService.RenderStepped:Connect(function()
				if Highlight then
					Highlight.Enabled = nv
				end
			end)
		end
	end

	victim.CharacterAdded:Connect(onCharacterAdded)
	
	if victim.Character then
		onCharacterAdded(victim.Character)
	end
end

task.spawn(function()
	while true do
		if nv then
			for _, entry in ipairs(NVHighlights) do
				local hl = entry.Highlight
				local ping = entry.Ping

				if hl and hl.Parent then
					ping:Play()
					hl.OutlineColor = Color3.fromRGB(255, 100, 100)
					local tween = TweenService:Create(hl, info, {OutlineColor = Ambient})
					tween:Play()
				end
			end
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
		plr.CharacterAdded:Connect(function(char)
			hl(char)
		end)
	else
		plr.CharacterAdded:Connect(function(char)
			cl(char)
		end)
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
