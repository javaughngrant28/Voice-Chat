

local SpaceTypes = require(script.Parent.SpaceTypes)
local CreateFolder = require(script.Parent.CreateFolder)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)


export type SpaceType = {
    Folder: SpaceTypes.SpaceFolder,
    Host: Player,
    
    new: (host: Player,spaceName: string, mapName: string, welcomeMessage: string) -> SpaceType,
    Destroy: (self: SpaceType) -> nil,
}


local Space = {}
Space.__index = Space

Space._MAID = nil

Space.Host = nil
Space.Folder = nil



function Space.new(host: Player,spaceName: string, mapName: string, welcomeMessage: string): SpaceType
    local self = setmetatable({}, Space)
    self:__Constructor(host,spaceName,mapName,welcomeMessage)
    return self
end


function Space:__Constructor(host: Player,spaceName: string, mapName: string, welcomeMessage: string)
    self._MAID = MaidModule.new()
    self.Host = host

    local folder = CreateFolder.Fire(host,spaceName,mapName,welcomeMessage)
    folder.Host.Value = host
    folder.MapName.Value = mapName
    folder.Parent = game.ReplicatedStorage.Spaces
    self._MAID['Folder'] = folder
    
    self.Folder = folder
end




function Space:Destroy()

    self._MAID:Destroy()
    for index, _ in pairs(self) do
         self[index] = nil
     end
end

return Space
