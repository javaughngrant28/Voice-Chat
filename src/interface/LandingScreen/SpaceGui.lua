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

    local gui = self:_CreateGui()
    gui.Parent = screen:FindFirstChildWhichIsA('ScrollingFrame',true)
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
    local memberCount = #members
    
    local spaceGui = BUTTON_TEMPLATE:Clone()
    local spaceMembers = spaceGui.Members
    local memberAmount = spaceMembers.ActiveCount.NumberLable :: TextLabel
    local pictureTemplate = spaceMembers.PictureTemplate :: ImageLabel
    local dotsPictureTemplate = spaceMembers.DotsPictureTemplate :: ImageLabel

    spaceGui.SpaceName.Text = self.Folder.Name
    spaceGui.HostPicture.Image = HostImage

    if memberCount <= 0 then
        memberAmount.Text = `1`
        local pictureClone = pictureTemplate:Clone()
        pictureClone.Image = HostImage
        pictureClone.Parent = pictureTemplate.Parent
        pictureClone.Visible = true

        else
            memberAmount.Text = `{memberCount}`

            for i= memberCount, 1, -1 do

                local playerMember = members[i] :: ObjectValue

                if i == 1 and memberAmount == 4 then
                    local dotsPictureClone = dotsPictureTemplate:Clone()
                    dotsPictureClone.Image = PlayerIcon.Get(playerMember.Value)
                    dotsPictureClone.Parent = dotsPictureTemplate.Parent
                    dotsPictureClone.Visible = true

                    else
                        local pictureClone = pictureTemplate:Clone()
                        pictureClone.Image = PlayerIcon.Get(playerMember.Value)
                        pictureClone.Visible = true
                        pictureClone.Parent = pictureTemplate.Parent
                end
            end

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