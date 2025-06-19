local execStart = tick()

local Global = (getgenv and getgenv()) or shared
local Optional = Global.Optional

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TestService = game:GetService("TestService")

local Player = Players.LocalPlayer -- Player
local PlayerGui = Player.PlayerGui -- Gui Objects

if PlayerGui:FindFirstChild("MobileButtonsLocal") then PlayerGui.MobileButtonsLocal:Destroy() end
local MobileButtons = Instance.new("ScreenGui", PlayerGui) -- Gui object
	MobileButtons.Name = "MobileButtonsLocal"
	MobileButtons.ResetOnSpawn = false -- Gui will not be reverted on respawn

local JumpButtonFrame = Instance.new("Frame", MobileButtons)
	JumpButtonFrame.Name = "JumpButtonFrame"
	JumpButtonFrame.Position = UDim2.new(1, -95, 1, -90)
	JumpButtonFrame.Size = UDim2.new(0, 70, 0, 70)
	JumpButtonFrame.BackgroundTransparency = 1

local GhostGui = Instance.new("ScreenGui", JumpButtonFrame) -- Used to get the AbsoluteSize of the Player's screen. Will not be displayed.
	GhostGui.Name = "GhostGui"
	GhostGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
	GhostGui.ClipToDeviceSafeArea = true
	GhostGui.SafeAreaCompatibility = Enum.SafeAreaCompatibility.FullscreenExtension

function inputUpdate()
	local lastInput = UserInputService:GetLastInputType()

	if lastInput == Enum.UserInputType.Focus then return end
	JumpButtonFrame.Visible = lastInput == Enum.UserInputType.Touch
end

inputUpdate()
UserInputService.LastInputTypeChanged:Connect(inputUpdate)

RunService.RenderStepped:Connect(function()
	if JumpButtonFrame.Visible then
		local screenSize = GhostGui.AbsoluteSize
		local minAxis = math.min(screenSize.X, screenSize.Y)
		local isSmallScreen = minAxis <= 500
		local jumpButtonSize = isSmallScreen and 70 or 120
		
		JumpButtonFrame.Size = UDim2.new(0, jumpButtonSize, 0, jumpButtonSize)
		JumpButtonFrame.Position = isSmallScreen and UDim2.new(1, -(jumpButtonSize*1.5-10), 1, -jumpButtonSize - 20) or UDim2.new(1, -(jumpButtonSize*1.5-10), 1, -jumpButtonSize * 1.75)
	end
end)

print("found the jump Button")
	TestService:Message(screenSize, "-", minAxis, "-", isSmallScreen, "-", jumpButtonSize)

local execEnd = tick()
print("Loaded main GUI in", tostring(execEnd-execStart) .. ".")

task.wait()
loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/spawn/refs/heads/main/FE/Sit.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/spawn/refs/heads/main/FE/Sprint.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/spawn/refs/heads/main/FE/Stun.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/spawn/refs/heads/main/FE/Suicide.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/spawn/refs/heads/main/FE/Zoom.lua"))()
if Optional.HealthBar then loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/spawn/refs/heads/main/FE/Optional/HealthBar.lua"))() end
if Optional.ShowLimbsInFP then loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/spawn/refs/heads/main/FE/Optional/BodyShownFP.lua"))() end
if Optional.InfiniteYield then loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/refs/heads/master/source"))() end
