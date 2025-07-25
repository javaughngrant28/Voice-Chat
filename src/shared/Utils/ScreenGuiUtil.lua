local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GuiFolder: Folder = ReplicatedStorage.Assets.ScreenGui


local function GetScreenGuiFromFolder(guiName: string): ScreenGui
    local screenGui = GuiFolder:FindFirstChild(guiName) :: ScreenGui
    assert(screenGui,`No Instance Found By Name: {guiName}`)
    assert(screenGui:IsA('ScreenGui'),`{guiName} Is Not A ScreenGui`)
    return screenGui
end

local function FindScreenInPlayer(player: Player, screenGui: string | ScreenGui): ScreenGui?
    local guiInstance: ScreenGui
    
    if player:FindFirstChild('PlayerGui') then
        if typeof(screenGui) == 'string' then
            guiInstance = player.PlayerGui:FindFirstChild(screenGui)
        else
            guiInstance = player.PlayerGui:FindFirstChild(screenGui.Name)
        end
    end
    
    if guiInstance then
        assert(guiInstance:IsA('ScreenGui'),`{guiInstance} Is Not A ScreenGui Insatnce`)
    end

    return guiInstance
end

local function DestroyGuiInstance(player: Player,screenGui: string | ScreenGui)
    local guiInstance = FindScreenInPlayer(player,screenGui)
    if guiInstance then
        guiInstance:Destroy()
    end
end

local function GetScrenGuiInstanceClone(screenGui: string | ScreenGui): ScreenGui
    local guiInstance: ScreenGui
    
    if typeof(screenGui) == 'string' then
        guiInstance = GetScreenGuiFromFolder(screenGui)
    else
        assert(screenGui:IsA('ScreenGui'),`{screenGui} Is Not A ScreenGui Insatnce`)
        guiInstance = screenGui
    end

    return guiInstance:Clone()
end

local function ForAllPlayersCallback(player: Player | {Player}, callBack: (player: Player)->())
    if typeof(player) == "table" then
        local playerTable = player :: {Player}
        for _, plr: Player in playerTable do
            assert(plr:IsA('Player'), 'Only Player Objects Expected')
            callBack(plr)
        end
        else
            local plr = player :: Player
            assert(plr:IsA('Player'), 'Invalid Player Prop')
            callBack(plr)
    end
end

local ScreenGuiUtil = {}

function ScreenGuiUtil.Find(player: Player, guiName: string): ScreenGui?
   local playerGui = player:FindFirstChild('PlayerGui')
   if not playerGui then return end

   local instance = playerGui:FindFirstChild(guiName)
   if not instance or not instance:IsA('ScreenGui') then return end

   return instance
end

function ScreenGuiUtil.Get(guiName: string)
    local screenGui = GetScreenGuiFromFolder(guiName) :: ScreenGui
    return screenGui
end

function ScreenGuiUtil.Add(player: Player| {Player},screenGui: string | ScreenGui): ScreenGui
   local guiInstanceClone = GetScrenGuiInstanceClone(screenGui) :: ScreenGui

   ForAllPlayersCallback(player,function(player: Player)
    guiInstanceClone.Parent = player.PlayerGui
   end)

   return guiInstanceClone
end

function ScreenGuiUtil.Remove(player: Player| {Player},screenGui: string | ScreenGui)
    ForAllPlayersCallback(player,function(player: Player)
        DestroyGuiInstance(player,screenGui)
    end)
end

function ScreenGuiUtil.RemoveFromAllPlayers(screenGui: string | ScreenGui)
    ForAllPlayersCallback(Players:GetChildren(),function(player: Player)
        DestroyGuiInstance(player,screenGui)
    end)
end

function ScreenGuiUtil.AddToAllPlayers(gui: ScreenGui | string)
    local function addGuiToPlayer(player)
        if not player:FindFirstChild("PlayerGui") then return end
        local clonedGui = GetScrenGuiInstanceClone(gui)
        clonedGui.Parent = player:FindFirstChild("PlayerGui")
    end

    for _, player in ipairs(Players:GetPlayers()) do
        addGuiToPlayer(player)
    end
end

function ScreenGuiUtil.AddToAllPlayersWithConnection(gui: ScreenGui | string, callback: (player: Player, screen: ScreenGui)->()?): RBXScriptConnection

    local function addGuiToPlayer(player)
        if not player:FindFirstChild("PlayerGui") then return end
        local clonedGui = GetScrenGuiInstanceClone(gui)
        clonedGui.Parent = player:FindFirstChild("PlayerGui")

        if callback then
            callback(player, clonedGui)
        end
    end

    local Connection = Players.PlayerAdded:Connect(addGuiToPlayer)
    
    for _, player in ipairs(Players:GetPlayers()) do
        addGuiToPlayer(player)
    end

    return Connection
end

return ScreenGuiUtil
