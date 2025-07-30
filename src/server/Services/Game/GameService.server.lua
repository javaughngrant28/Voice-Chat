
local SpaceAPI = require(game.ServerScriptService.Services.Space.SpaceAPI)
local RemoteUtil = require(game.ReplicatedStorage.Shared.Utils.RemoteUtil)

local DEFULT_SPACE_FOLDER: Folder
local DEFAUL_NAME = 'Chill Vibes'
local DEFAUL_MAP_NAME = 'Map_1'
local DEFAUL_WELCOME_MESSAGE = 'Follow Da Rules'

local function CreateDefultSpaceFolder()
    DEFULT_SPACE_FOLDER = SpaceAPI.CreateFolder(DEFAUL_NAME,DEFAUL_MAP_NAME,DEFAUL_WELCOME_MESSAGE)
    DEFULT_SPACE_FOLDER.Parent = game.ReplicatedStorage.Spaces
end

CreateDefultSpaceFolder()


local function JoinSpaceRequest(player: Player, folder: Folder)
    if folder == DEFULT_SPACE_FOLDER then
        SpaceAPI.Create(player,DEFAUL_NAME,DEFAUL_MAP_NAME,DEFAUL_WELCOME_MESSAGE)
        DEFULT_SPACE_FOLDER:Destroy()
    end
end


RemoteUtil.OnServer('JoinSpaceRequest',JoinSpaceRequest)

