
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local landingscreen: ScreenGui = ReplicatedStorage.Assets.ScreenGui.LandingScreen



local function PlayerAdded(player: Player)
    local landingscreenClone = landingscreen:Clone()
    landingscreenClone.Parent = player.PlayerGui
end



Players.PlayerAdded:Connect(PlayerAdded)

