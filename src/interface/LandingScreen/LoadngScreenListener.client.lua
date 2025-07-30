
local UIDetector = require(script.Parent.Parent.Modules.UIDetector)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)
local SpaceGui = require(script.Parent.SpaceGui)

local SpaceFolder = game.ReplicatedStorage.Spaces

local Maid: MaidModule.Maid = MaidModule.new()

local function CreateSpaceGui(folder: Instance, screen: ScreenGui)
    if not folder:IsA('Folder') then return end
    Maid[folder] = SpaceGui.new(folder,screen)
end

local function screenAdded(screen: ScreenGui)
    Maid[screen] = SpaceFolder.ChildAdded:Connect(function(child: Instance)
        CreateSpaceGui(child,screen)
    end)

    for _, child: Instance in SpaceFolder:GetChildren() do
        CreateSpaceGui(child,screen)
    end
end


UIDetector.new('LandingScreen',screenAdded)


