local Signal = require(game.ReplicatedStorage.Shared.Libraries.Signal)

local LoadSignal = Signal.new()
local DestroySignal = Signal.new()

local API = {}

function  API._GetLoadSignal(): Signal.SignalType
    return LoadSignal
end

function  API._GetDestroySignal(): Signal.SignalType
    return DestroySignal
end

function API.Load(player: Player)
    LoadSignal:Fire(player)
end

function API.Destroy(...:any?)
    DestroySignal:Fire(...)
end

return API