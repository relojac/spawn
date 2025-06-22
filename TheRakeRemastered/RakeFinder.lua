Instance.new("Highlight", workspace:FindFirstChild("Rake"))

workspace.ChildAdded:Connect(function(Child)
	if Child.Name == "Rake" then
		Instance.new("Highlight", Child)
	end
end)
