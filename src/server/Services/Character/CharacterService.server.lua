
local CharacterAPI = require(script.Parent.CharacterAPI)

local LoadSignal = CharacterAPI._GetLoadSignal()

local function Load(player: Player)
    local existingCharacter = player.Character

    if existingCharacter then
        player.Character:Destroy()
        player.Character = nil
        task.wait(1)
    end

    player:LoadCharacter()
end


LoadSignal:Connect(Load)
