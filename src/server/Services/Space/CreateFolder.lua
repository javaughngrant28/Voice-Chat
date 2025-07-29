
local SpaceTypes = require(script.Parent.SpaceTypes)

local function CreateSpaceFolder(host: Player?,spaceName: string, mapName: string, welcomeMessage: string): SpaceTypes.SpaceFolder
    local folder = Instance.new('Folder')
    folder.Name = spaceName

    local members = Instance.new('Folder')
    members.Name = 'Members'
    members.Parent = folder

    local host = Instance.new('ObjectValue')
    host.Name = 'Host'
    host.Value = host or nil
    host.Parent = folder

    local coHosts = Instance.new('Folder')
    coHosts.Name = 'CoHost'
    coHosts.Parent = folder

    local welcomeMassge = Instance.new('StringValue')
    welcomeMassge.Name = 'WelcomeMessage'
    welcomeMassge.Parent = folder

    local mapName = Instance.new('StringValue')
    mapName.Name = 'MapName'
    mapName.Parent = folder

    return folder
end

return {
    Fire = CreateSpaceFolder
}