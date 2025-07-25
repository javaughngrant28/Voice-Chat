local soundService = game:GetService('SoundService')
local SoundUtil = {}

function SoundUtil.PlayFromPlayerCharacter(target: Player | Model, sound: Sound)
	if target == nil or sound == nil or sound.ClassName ~= 'Sound' then return end

	local character: Model =  target.ClassName == 'Model' and target or target.Character
	if character == nil then return end

	local hrp: Part = character:FindFirstChild('HumanoidRootPart')
	if hrp == nil then return end

	local newSound = sound:Clone()
	newSound.PlayOnRemove = true
	newSound.Parent = hrp

	newSound:Destroy()
end

function SoundUtil.PlaySoundInElement(soundReffrence: Sound, element: GuiObject)
    if not soundReffrence then
        warn('Sound Not Found')
        return
    end

    local sound = soundReffrence:Clone()
    sound.PlayOnRemove = true
    sound.Parent = element
    sound:Destroy()
end

function SoundUtil.PlayInPart(sound: Sound, part: BasePart)
	if sound == nil or part == nil then return end
	if sound.ClassName ~= 'Sound' then return end

	local newSound = sound:Clone()
	newSound.PlayOnRemove = true
	newSound.Parent = part

	newSound:Destroy()
end

function SoundUtil.CreateSoundFromIdAndPlayInPart(soundId: string, part: Part)
	if soundId == nil or part == nil then return end

	local newSound = Instance.new('Sound')
	newSound.SoundId = soundId
	newSound.PlayOnRemove = true
	newSound.Parent = part

	newSound:Destroy()
end

function SoundUtil.PlayOnClient(sound: Sound)
	if sound == nil then return end
	if not sound:IsA('Sound') then return end

	local newSound = sound:Clone()
	newSound.PlayOnRemove = true
	newSound.Parent = soundService
	
	newSound:Destroy()
end

return SoundUtil