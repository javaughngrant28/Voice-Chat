
local SpaceTypes = require(script.Parent.SpaceTypes)

local function CreateSpaceFolder(host: Player?,spaceName: string, mapName: string, welcomeMessage: string): SpaceTypes.SpaceFolder
    local folder = Instance.new('Folder')
    folder.Name = spaceName

    local members = Instance.new('Folder')
    members.Name = 'Members'
    members.Parent = folder

    local Host = Instance.new('ObjectValue')
    Host.Name = 'Host'
    Host.Value = host or nil
    Host.Parent = folder

    local coHosts = Instance.new('Folder')
    coHosts.Name = 'CoHost'
    coHosts.Parent = folder

    local WelcomeMassge = Instance.new('StringValue')
    WelcomeMassge.Name = 'WelcomeMessage'
    WelcomeMassge.Value = welcomeMessage
    WelcomeMassge.Parent = folder

    local MapName = Instance.new('StringValue')
    MapName.Name = 'MapName'
    MapName.Value = mapName
    MapName.Parent = folder

    return folder
end

return {
    Fire = CreateSpaceFolder
}