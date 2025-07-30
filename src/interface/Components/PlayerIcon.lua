local Players = game:GetService("Players")


local function GetPlayersIcon(player: Player)
    local userId = player.UserId
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size420x420
    return Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
end


return {
    Get = GetPlayersIcon,
}
