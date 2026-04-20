extends Node

signal configChanged(config: ConfigFile)

var McmHelpers = preload("res://ModConfigurationMenu/Scripts/Doink Oink/MCM_Helpers.tres")


const MOD_ID = "Populated"
const FILE_PATH = "user://MCM/Populated"

func mylog(message:String, level:String = "INFO"):
    print(MOD_ID + " [" + level + "]>" + message)


var _config = ConfigFile.new()

func _ready() -> void:
    _config.set_value("Float", "startValue", {
        "name" = "startValue",
        "tooltip" = "spawn timer duration at start of map(only changes on map reload)",
        "default" = 1.0,
        "value" = 1.0,
        "minRange" = 0.0,
        "maxRange" = 5*60,
        "menu_pos" = 1,
        "category" = "Spawn Shaping"
    })

    _config.set_value("Float", "targetValue", {
        "name" = "targetValue",
        "tooltip" = "spawn timer duration to tend toward in seconds",
        "default" = 60,
        "value" = 60,
        "minRange" = 1.0,
        "maxRange" = 5*60,
        "menu_pos" = 2,
        "category" = "Spawn Shaping"
    })
    _config.set_value("Float", "easing", {
        "name" = "easing",
        "tooltip" = "easing to apply. values < 1 start fast end slow, values > 1 start slow end fast, values == 0 disables easing. will always be targetValue",
        "default" = 1.5,
        "value" = 0.8,
        "minRange" = 0,
        "maxRange" = 4.0,
        "menu_pos" = 3,
        "category" = "Spawn Shaping"
    })
    _config.set_value("Int", "targetTime", {
        "name" = "targetTime",
        "tooltip" = "how long after level load until spawnTime will match the targetValue in seconds(easing must be set to non 0 value to enable",
        "default" = 15*60,
        "value" = 15*60,
        "minRange" = 1,
        "maxRange" = 60*60,
        "menu_pos" = 4,
        "category" = "Spawn Shaping"
    })


    _config.set_value("Int", "spawnPool", {
        "name" = "spawnPool",
        "tooltip" = "enemies to spawn in total(only changes on map reload)",
        "default" = 10,
        "value" = 25,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 5,
        "category" = "Default Map Settings"
    })

    _config.set_value("Int", "spawnLimit", {
        "name" = "spawnLimit",
        "tooltip" = "max spawned enemies",
        "default" = 10,
        "value" = 10,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 6,
        "category" = "Default Map Settings"
    })
    _config.set_value("Bool", "showDebug", {
        "name" = "showDebug",
        "tooltip" = "show debug info(enable the Map HUD option)",
        "default" = false,
        "value" = false,
        "menu_pos" = 7,
    })

    _config.set_value("Bool", "Village_UseCustom", {
        "name" = "Village_UseCustom",
        "tooltip" = "use custom map settings(below)",
        "default" = false,
        "value" = false,
        "menu_pos" = 1,
        "category" = "Village Map Settings"
    })
    _config.set_value("Int", "Village_spawnPool", {
        "name" = "Village_spawnPool",
        "tooltip" = "enemies to spawn in total(only changes on map reload)",
        "default" = 10,
        "value" = 25,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 2,
        "category" = "Village Map Settings"
    })

    _config.set_value("Int", "Village_spawnLimit", {
        "name" = "Village_spawnLimit",
        "tooltip" = "max spawned enemies",
        "default" = 10,
        "value" = 10,
        "minRange" = 0,
        "maxRange" = 1000,
        "menu_pos" = 3,
        "category" = "Village Map Settings"
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
    printConfig()

func printConfig():
    mylog("spawnLimit :%s" % _config.get_value("Int", "spawnLimit").value)
    mylog("spawnPool :%s" % _config.get_value("Int", "spawnPool").value)
    mylog("targetTime :%0.2f" % _config.get_value("Int", "targetTime").value)
    mylog("startValue :%0.2f" % _config.get_value("Float", "startValue").value)
    mylog("targetValue :%0.2f" % _config.get_value("Float", "targetValue").value)
    mylog("easing :%0.2f" % _config.get_value("Float", "easing").value)
    mylog("showDebug :%s" % _config.get_value("Bool", "showDebug").value)

func updateSignal(config:ConfigFile):
    configChanged.emit(config)