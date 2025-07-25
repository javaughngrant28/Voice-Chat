
local RemoteUtil = require(game.ReplicatedStorage.Shared.Utils.RemoteUtil)
local CharacterAPI = require(script.Parent.Parent.Character.CharacterAPI)


local function HostRquest(player: Player)
    local landingscreen = player.PlayerGui:FindFirstChild('LandingScreen')
    if landingscreen then landingscreen:Destroy() end
    CharacterAPI.Load(player)
end


RemoteUtil.OnServer('Host',HostRquest)


