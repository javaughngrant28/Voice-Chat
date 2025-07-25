
local Signal = require(game.ReplicatedStorage.Shared.Libraries.Signal)

local LoadSignal = Signal.new()
local DestroySignal = Signal.new()

local function GetLoadSignal(): Signal.SignalType
    return LoadSignal
end

local function GetDestroySignal(): Signal.SignalType
    return DestroySignal
end

local function Load(player: Player)
    LoadSignal:Fire(player)
end

local function Destroy(...:any?)
    DestroySignal:Fire(...)
end

return {
    Load = Load,
    Destroy = Destroy,

    _LoadSignal = GetLoadSignal,
    _DestroySignal = GetDestroySignal,
}
