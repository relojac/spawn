local Global = (getgenv and getgenv()) or shared
Global.SpawnUtilsConfig = {
	["Sprint"] = {
		["Easing"] = {
			["In"] = {
				["Time"] = 0.75,
				["Style"] = Enum.EasingStyle.Sine,
				["Direction"] = Enum.EasingDirection.InOut
			},
			["Out"] = {
				["Time"] = 1,
				["Style"] = Enum.EasingStyle.Exponential,
				["Direction"] = Enum.EasingDirection.Out
			}
		},
		["Multipliers"] = {
			["WalkSpeed"] = 1.5,
			["FieldOfView"] = 1.3
		},
		["ButtonToggleable"] = true
	},
	["Suicide"] = {
		["Tween"] = false
	}
}
Global.Values = {
	["FirstPersonLock"] = false
}
Global.Optional = {
	["HealthBar"] = true,
	["ShowLimbsInFP"] = true
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/spawn/refs/heads/main/FE/Main.lua"))()
