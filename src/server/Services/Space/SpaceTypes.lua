
type PlayerFolder = {
    ObjectValue
}

export type SpaceFolder = {
    Name: string,
    Parent: Instance?,
    Host: ObjectValue,
    CoHost: PlayerFolder,
    Members: PlayerFolder,
    WelcomeMessage: StringValue,
    MapName: StringValue,
}

return {}


