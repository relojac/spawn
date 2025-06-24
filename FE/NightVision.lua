local execStart = tick() -- *starts timer* okay time to write code

local NVHighlights = {}

local Global = (getgenv and getgenv()) or shared
local Config = Global.SpawnUtilsConfig.NightVision

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local AmbientColor = Config.AmbientColor
local PingColor = Config.PingColor
local Psychopathic = Config.Psychopathic

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local msgs = {
	"IT'S ALL YOUR FAULT",
	"YOU NEED TO KEEP THE GOGGLES ON",
	"TAKE THE GOGGLES OFF",
	"MURDERER",
	"FUCK YOU",
	"YOU'LL PAY FOR WHAT YOU DID",
	"TAKE IT OFF",
	"POISON",
	"LOSER",
	"YOU GODDAMN MONSTER",
	"YOU'RE NOT GETTING AWAY THIS Time",
	"WHY DID YOU KILL HER?",
	"YOU FUCKING IMBECILE",
	"JUMP",
	"END IT"
}

local MobileButtons = PlayerGui:WaitForChild("MobileButtonsLocal")
local JumpButtonFrame = MobileButtons.JumpButtonFrame

local NVButton = Instance.new("ImageButton", JumpButtonFrame)
	NVButton.Name = "NVButton"
	NVButton.Position = UDim2.new(-3.3, 0, 0, 0)
	NVButton.Size = UDim2.new(1, 0, 1, 0)
	NVButton.BackgroundTransparency = 1
	NVButton.Active = true
	NVButton.Image = "rbxassetid://132894389548973"

local NVE = Instance.new("ColorCorrectionEffect", Lighting)
	NVE.Name = "NVE_1"
	NVE.Enabled = false
	NVE.TintColor = AmbientColor
	NVE.Contrast = 0.2
	NVE.Saturation = -1
	NVE.Brightness = 0.5

local VignetteGui = Instance.new("ScreenGui", PlayerGui)
	VignetteGui.Name = "VignetteGuiLocal"
	VignetteGui.Enabled = false
	VignetteGui.IgnoreGuiInset = true

local Vignette = Instance.new("ImageLabel", VignetteGui)
	Vignette.Name = "Vignette"
	Vignette.Image = "rbxassetid://113537235654608"
	Vignette.Size = UDim2.new(1, 0, 1, 0)
	Vignette.BackgroundTransparency = 1

local Subtitle = Instance.new("TextLabel", VignetteGui)
	Subtitle.Name = "Subtitle"
	Subtitle.Text = msgs[1]
	Subtitle.BackgroundTransparency = 1
	Subtitle.Font = Enum.Font.Code
	Subtitle.TextColor3 = AmbientColor
	Subtitle.Visible = false
	Subtitle.AnchorPoint = Vector2.new(0.5, 1)
	Subtitle.Size = UDim2.new(1, 0, 0.2, 0)
	Subtitle.TextSize = 7
	Subtitle.Position = UDim2.new(0, -25, 0, 0)

local SoundOn = Instance.new("Sound", SoundService)
	SoundOn.Name = "NightVisionOn"
	SoundOn.SoundId = "rbxassetid://376178316"
local SoundOff = Instance.new("Sound", SoundService)
	SoundOff.Name = "NightVisionOff"
	SoundOff.SoundId = "rbxassetid://79003354998655"

local Ping = Instance.new("Sound", SoundService) -- Could you make me a drink that stops the disorienting beeping noise in my head?
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
		light.Brightness = 1.25
		light.Color = AmbientColor
		light.Shadows = false
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
		task.spawn(function()
			local hrp = char:FindFirstChild("HumanoidRootPart")
			while not hrp do
				char.ChildAdded:Wait()
				hrp = char:FindFirstChild("HumanoidRootPart")
			end
	
			local Highlight = Instance.new("Highlight", char)
				Highlight.Name = "NV_hl"
				Highlight.FillTransparency = 1
				Highlight.OutlineColor = AmbientColor
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
	local char = plr.Character
	local hrp = char:WaitForChild("HumanoidRootPart")

	if not char then return end

	local corpse = plr.UserId
	local corpseName = plr.DisplayName or plr.Name
	local phantom = Players:CreateHumanoidModelFromUserId(corpse)
		phantom.Name = string.reverse(corpseName)
		phantom:SetPrimaryPartCFrame(hrp.CFrame)
		phantom:TranslateBy(Vector3.new(5, 0, 5))
	local loop

	local function stare()
		if hrp and phantom then
			local pPos = phantom.PrimaryPart.Position
			local cPos = hrp.Position
			local modCPos = Vector3.new(cPos.X, pPos.Y, cPos.Z)
			local newCF = CFrame.new(pPos, modCPos)

			phantom:SetPrimaryPartCFrame(newCF)
		else
			loop:Disconnect()
		end
	end

	for _, obj in ipairs(phantom:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Transparency = 0.2
			obj.CanCollide = false
			obj.Anchored = true
		end
	end

	local ghostHl = Instance.new("Highlight", phantom)
		ghostHl.Name = "GhostHighlight"
		ghostHl.FillTransparency = 0.5
		ghostHl.OutlineColor = Color3.new(1, 0, 0)
		ghostHl.FillColor = Color3.new(0, 0, 0)

	local Static = Instance.new("Sound", phantom.HumanoidRootPart)
		Static.Name = "Static"
		Static.SoundId = "rbxassetid://4860560167"
		Static.Volume = 0.35
		Static.Looped = true
		Static.Playing = true

	Subtitle.Text = msgs[math.random(1, #msgs)]
	Subtitle.Visible = true
	
	loop = RunService.RenderStepped:Connect(stare)

	Debris:AddItem(phantom, math.random(1, 3))
	
	while true do
		if not phantom then
			Subtitle.Visible = false
			break
		end
	end
end

task.spawn(function()
	while true do
		if nv then
			for _, entry in ipairs(NVHighlights) do
				local hl = entry.Highlight

				if hl and hl.Parent then
					hl.OutlineColor = PingColor
					NVE.TintColor = PingColor
					Subtitle.TextColor3 = PingColor
						
					local tween1 = TweenService:Create(hl, info, {OutlineColor = AmbientColor})
					local tween2 = TweenService:Create(NVE, info, {TintColor = AmbientColor})
					local tween3 = TweenService:Create(Subtitle, info, {TextColor3 = AmbientColor})
					
					tween1:Play()
					tween2:Play()
					tween3:Play()

					if math.random() < 0.2 and Psychopathic then
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

local execEnd = tick() -- *stops timer* okay done :3
print("Loaded in " .. tostring(execEnd-execStart) .. ".")
