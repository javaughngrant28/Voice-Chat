
local UIDetector = require(script.Parent.Parent.Modules.UIDetector)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)
local RemoteUtil = require(game.ReplicatedStorage.Shared.Utils.RemoteUtil)

local Maid: MaidModule.Maid = MaidModule.new()


local function HostButtonActivated()
    RemoteUtil.FireServer('Host')
end

local function LandingScreenAdded(screen: ScreenGui)
    local HostButton = screen:FindFirstChild('Host',true) :: GuiButton
    Maid['HostButton Connection'] = HostButton.Activated:Connect(HostButtonActivated)
end


UIDetector.new('LandingScreen',LandingScreenAdded)


