local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer -- Player
local PlayerGui = Player.PlayerGui -- Gui Objects

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
	local lastInput = UserInputService:GetLastInputType( )

	if lastInput == Enum.UserInputType.Focus then return end
	frame.Visible = lastInput == Enum.UserInputType.Touch
end

inputUpdate()
UserInputService.LastInputTypeChanged:Connect(inputUpdate)

RunService.RenderStepped:Connect(function()
	if frame.Visible then
		local screenSize = 
	end
end)
