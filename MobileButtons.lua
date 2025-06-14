local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local frame = script.Parent

function inputUpd()
	local lastInput = uis:GetLastInputType()
	
	if lastInput == Enum.UserInputType.Focus then return end
	frame.Visible = lastInput == Enum.UserInputType.Touch
end

inputUpd()
uis.LastInputTypeChanged:Connect(inputUpd)

rs.RenderStepped:Connect(function()
	if frame.Visible then
		local screenSize = frame:FindFirstChildOfClass("ScreenGui").AbsoluteSize
		local minAxis = math.min(screenSize.X, screenSize.Y)
		local isSmallScreen = minAxis <= 500
		local jumpButtonSize = isSmallScreen and 70 or 120
		frame.Size = UDim2.new(0, jumpButtonSize, 0, jumpButtonSize)
		frame.Position = isSmallScreen and UDim2.new(1, -(jumpButtonSize*1.5-10), 1, -jumpButtonSize - 20) or UDim2.new(1, -(jumpButtonSize*1.5-10), 1, -jumpButtonSize * 1.75)
	end
end)
