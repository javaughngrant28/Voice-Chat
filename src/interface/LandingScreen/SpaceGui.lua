local Players = game:GetService("Players")

local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)
local PlayerIcon = require(script.Parent.Parent.Components.PlayerIcon)

local BUTTON_TEMPLATE = game.ReplicatedStorage.Assets.GuiElements.SpaceButtonTemplate


export type SpaceGuiType = {
    Folder: Folder,
    new: (folder: Folder, screen: ScreenGui) -> SpaceGuiType,
    Destroy: (self: SpaceGuiType) -> nil,
}


local SpaceGui = {}
SpaceGui.__index = SpaceGui

SpaceGui._MAID = nil

SpaceGui.Folder = nil



function SpaceGui.new(folder: Folder, screen: ScreenGui): SpaceGuiType
    local self = setmetatable({}, SpaceGui)
    self:__Constructor(folder,screen)
    return self
end


function SpaceGui:__Constructor(folder: Folder, screen: ScreenGui)
    self._MAID = MaidModule.new()
    self.Folder = folder

    self:_AutoCleanup()
end

function SpaceGui:_AutoCleanup()
    local folder = self.Folder :: Folder

    if folder.Parent == nil then
        self:Destroy()
    end

    self._MAID['Folder AncestryChanged'] = folder.AncestryChanged:Connect(function(_, parent)
        if parent == nil then
            self:Destroy()
        end
    end)
end

function SpaceGui:_CreateGui(): GuiButton
    local Host = self.Folder.Host :: ObjectValue
    local members = self.Folder.Members:GetChildren()
    local HostPlayer = Host.Value or Players.LocalPlayer
    local HostImage = PlayerIcon.Get(HostPlayer)
    
    local spaceGui = BUTTON_TEMPLATE:Clone()
    local spaceMembers = spaceGui.Members
    local memberAmount = spaceMembers.ActiveCount.NumberLable :: TextLabel
    local pictureTemplate = spaceMembers.PictureTemplate :: ImageLabel
    local dotsPictureTemplate = spaceMembers.DotsPictureTemplate :: ImageLabel

    spaceGui.SpaceName.Text = self.Folder.Name
    spaceGui.HostPicture.Image = HostImage

    if #members <= 0 then
        memberAmount.Text = `1`
        local pictureClone = pictureTemplate:Clone()
        pictureClone.Image = HostImage
        pictureClone.Parent = pictureTemplate.Parent

        else
            memberAmount.Text = `{#memberAmount}`

    end 
    
    return spaceGui
end

function SpaceGui:Destroy()

    self._MAID:Destroy()
    for index, _ in pairs(self) do
         self[index] = nil
     end
end

return SpaceGui