local Signal = require(game.ReplicatedStorage.Shared.Libraries.Signal)
local CreateFolder = require(script.Parent.CreateFolder)
local SpaceTypes = require(script.Parent.SpaceTypes)

local CreateSignal = Signal.new()
local DestroySignal = Signal.new()

local API = {}

function API._GetCreateSignal(): Signal.SignalType
    return CreateSignal
end

function API._GetDestroySignal(): Signal.SignalType
    return DestroySignal
end

function API.CreateFolder(spaceName: string, mapName: string, welcomeMessage: string): SpaceTypes.SpaceFolder
    return CreateFolder.Fire(nil,spaceName,mapName,welcomeMessage)
end

function API.Create(host: Player,spaceName: string, mapName: string, welcomeMessage: string)
    CreateSignal:Fire(host,spaceName,mapName,welcomeMessage)
end

function API.Destroy(hostName: string)
    DestroySignal:Fire(hostName)
end

return API