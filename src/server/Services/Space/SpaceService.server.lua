
local SpaceAPI = require(script.Parent.SpaceAPI)
local Space = require(script.Parent.Space)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)

local Maid: MaidModule.Maid = MaidModule.new()

local CreateSignal = SpaceAPI._GetCreateSignal()
local DestroySignal = SpaceAPI._GetDestroySignal()




local function Create(host: Player,spaceName: string, mapName: string, welcomeMessage: string)
    local space = Space.new(host,spaceName,mapName,welcomeMessage)
    Maid[host.Name] = space
end

local function Destroy(hostName: string)
    Maid[hostName] = nil
end


CreateSignal:Connect(Create)
DestroySignal:Connect(Destroy)

