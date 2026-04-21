extends Node

signal configChanged(config: ConfigFile)

var McmHelpers = preload("res://ModConfigurationMenu/Scripts/Doink Oink/MCM_Helpers.tres")


const MOD_ID = "Populated"
const FILE_PATH = "user://MCM/RTV_Populated"
var _config = ConfigFile.new()

func _ready() -> void:
    _config.set_value("Category", "Debug", {
        "menu_pos" = 1
    })
    _config.set_value("Category", "Default Map Settings", {
        "menu_pos" = 2
    })
    _config.set_value("Category", "Easing Settings", {
        "menu_pos" = 3
    })

    _config.set_value("Bool", "showDebug", {
        "name" = "Show Debug",
        "tooltip" = "show debug info(enable the Map HUD option)",
        "default" = false,
        "value" = false,
        "menu_pos" = 1,
        "category" = "Debug"
    })
    _config.set_value("Float", "easing", {
        "name" = "Easing",
        "tooltip" = "easing to apply. values < 1 start fast end slow, values > 1 start slow end fast, values == 0 disables easing which will always be targetValue",
        "default" = 0.8,
        "value" = 0.8,
        "minRange" = 0,
        "maxRange" = 4.0,
        "menu_pos" = 1,
        "category" = "Easing Settings"
    })
    _config.set_value("Float", "startValue", {
        "name" = "Start Value",
        "tooltip" = "Spawn time at start of match",
        "default" = 10 * 60,
        "value" = 10 * 60,
        "minRange" = 1,
        "maxRange" = 60 * 60,
        "menu_pos" = 2,
        "category" = "Easing Settings"
    })
    _config.set_value("Float", "targetValue", {
        "name" = "Target Value",
        "tooltip" = "Spawn time at target time",
        "default" = 60,
        "value" = 60,
        "minRange" = 1,
        "maxRange" = 5 * 60,
        "menu_pos" = 3,
        "category" = "Easing Settings"
    })
    _config.set_value("Float", "targetTime", {
        "name" = "Target Time",
        "tooltip" = "how long after level load until spawnTime will match the targetValue in seconds",
        "default" = 10 * 60,
        "value" = 10 * 60,
        "minRange" = 1,
        "maxRange" = 60 * 60,
        "menu_pos" = 4,
        "category" = "Easing Settings"
    })
    _config.set_value("Int", "spawnLimit", {
        "name" = "Spawn Limit",
        "tooltip" = "max spawned enemies",
        "default" = 3,
        "value" = 3,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 1,
        "category" = "Default Map Settings"
    })
    _config.set_value("Int", "spawnPool", {
        "name" = "Spawn Pool",
        "tooltip" = "enemies to spawn in total",
       "default" = 3,
        "value" = 3,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 2,
        "category" = "Default Map Settings"
    })

    # Minefield Map Settings
    _config.set_value("Bool", "Minefield_UseCustom", {
        "name" = "Enable Custom Map Settings",
        "tooltip" = "use custom map settings(below)",
        "default" = false,
        "value" = false,
        "menu_pos" = 1,
        "category" = "Minefield Map Settings"
    })
    _config.set_value("Int", "Minefield_spawnPool", {
        "name" = "Spawn Pool",
        "tooltip" = "enemies to spawn in total(only changes on map reload)",
        "default" = 3,
        "value" = 3,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 2,
        "category" = "Minefield Map Settings"
    })
    _config.set_value("Int", "Minefield_spawnLimit", {
        "name" = "Spawn Limit",
        "tooltip" = "max spawned enemies",
        "default" = 3,
        "value" = 3,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 3,
        "category" = "Minefield Map Settings"
    })

    # Apartments Map Settings
    _config.set_value("Bool", "Apartments_UseCustom", {
        "name" = "Enable Custom Map Settings",
        "tooltip" = "use custom map settings(below)",
        "default" = false,
        "value" = false,
        "menu_pos" = 1,
        "category" = "Apartments Map Settings"
    })
    _config.set_value("Int", "Apartments_spawnPool", {
        "name" = "Spawn Pool",
        "tooltip" = "enemies to spawn in total(only changes on map reload)",
      "default" = 3,
        "value" = 3,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 2,
        "category" = "Apartments Map Settings"
    })
    _config.set_value("Int", "Apartments_spawnLimit", {
        "name" = "Spawn Limit",
        "tooltip" = "max spawned enemies",
       "default" = 3,
        "value" = 3,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 3,
        "category" = "Apartments Map Settings"
    })

    # Terminal Map Settings
    _config.set_value("Bool", "Terminal_UseCustom", {
        "name" = "Enable Custom Map Settings",
        "tooltip" = "use custom map settings(below)",
        "default" = false,
        "value" = false,
        "menu_pos" = 1,
        "category" = "Terminal Map Settings"
    })
    _config.set_value("Int", "Terminal_spawnPool", {
        "name" = "Spawn Pool",
        "tooltip" = "enemies to spawn in total(only changes on map reload)",
      "default" = 3,
        "value" = 3,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 2,
        "category" = "Terminal Map Settings"
    })
    _config.set_value("Int", "Terminal_spawnLimit", {
        "name" = "Spawn Limit",
        "tooltip" = "max spawned enemies",
       "default" = 3,
        "value" = 3,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 3,
        "category" = "Terminal Map Settings"
    })

    # School Map Settings
    _config.set_value("Bool", "School_UseCustom", {
        "name" = "Enable Custom Map Settings",
        "tooltip" = "use custom map settings(below)",
        "default" = false,
        "value" = false,
        "menu_pos" = 1,
        "category" = "School Map Settings"
    })
    _config.set_value("Int", "School_spawnPool", {
        "name" = "Spawn Pool",
        "tooltip" = "enemies to spawn in total(only changes on map reload)",
      "default" = 3,
        "value" = 3,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 2,
        "category" = "School Map Settings"
    })
    _config.set_value("Int", "School_spawnLimit", {
        "name" = "Spawn Limit",
        "tooltip" = "max spawned enemies",
       "default" = 3,
        "value" = 3,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 3,
        "category" = "School Map Settings"
    })

    # Outpost Map Settings
    _config.set_value("Bool", "Outpost_UseCustom", {
        "name" = "Enable Custom Map Settings",
        "tooltip" = "use custom map settings(below)",
        "default" = false,
        "value" = false,
        "menu_pos" = 1,
        "category" = "Outpost Map Settings"
    })
    _config.set_value("Int", "Outpost_spawnPool", {
        "name" = "Spawn Pool",
        "tooltip" = "enemies to spawn in total(only changes on map reload)",
      "default" = 3,
        "value" = 3,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 2,
        "category" = "Outpost Map Settings"
    })
    _config.set_value("Int", "Outpost_spawnLimit", {
        "name" = "Spawn Limit",
        "tooltip" = "max spawned enemies",
       "default" = 3,
        "value" = 3,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 3,
        "category" = "Outpost Map Settings"
    })

    # Highway Map Settings
    _config.set_value("Bool", "Highway_UseCustom", {
        "name" = "Enable Custom Map Settings",
        "tooltip" = "use custom map settings(below)",
        "default" = false,
        "value" = false,
        "menu_pos" = 1,
        "category" = "Highway Map Settings"
    })
    _config.set_value("Int", "Highway_spawnPool", {
        "name" = "Spawn Pool",
        "tooltip" = "enemies to spawn in total(only changes on map reload)",
      "default" = 3,
        "value" = 3,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 2,
        "category" = "Highway Map Settings"
    })
    _config.set_value("Int", "Highway_spawnLimit", {
        "name" = "Spawn Limit",
        "tooltip" = "max spawned enemies",
       "default" = 3,
        "value" = 3,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 3,
        "category" = "Highway Map Settings"
    })
    if !FileAccess.file_exists(FILE_PATH + "/config.ini"):
        DirAccess.open("user://").make_dir(FILE_PATH)
        _config.save(FILE_PATH + "/config.ini")
    else:
        McmHelpers.CheckConfigurationHasUpdated(MOD_ID, _config, FILE_PATH + "/config.ini")
        _config.load(FILE_PATH + "/config.ini")


    McmHelpers.RegisterConfiguration(
        MOD_ID,
        "Populated",
        FILE_PATH,
        "Advanced Bot Spawner",
        {
         "/config.ini" = updateSignal
        }
    )


func updateSignal(config: ConfigFile):
    configChanged.emit(config)