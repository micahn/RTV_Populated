extends "res://Scripts/AISpawner.gd"

var startTime : int
var targetTime : int
var startValue : float
var targetValue : float
var easing : float
var McmHelpers = preload("res://ModConfigurationMenu/Scripts/Doink Oink/MCM_Helpers.tres")
var lockConfig = false
func _load_new_config(config: ConfigFile):
    spawnLimit = config.get_value("Int", "spawnLimit").value
    targetTime = config.get_value("Float", "targetTime").value
    targetValue = config.get_value("Float", "targetValue").value
    easing = config.get_value("Float", "easing").value
    if !lockConfig:
        spawnPool = config.get_value("Int", "spawnPool").value
        startValue = config.get_value("Float", "startValue").value
        var mapname = get_parent().mapName

        lockConfig = true


func _ready() -> void:
    var PC = get_tree().root.get_node("/root/ModLoader/RTV_PopulatedConfig")
    _load_new_config(PC._config)
    super()
    PC.configChanged.connect(_load_new_config)
    startTime = Time.get_ticks_msec()
    





func easeSpawnTime():
    var progress = ((Time.get_ticks_msec() - startTime)/1000.0) / float(targetTime)
    return startValue + ((targetValue-startValue) * pow(progress, easing))


func _physics_process(delta) -> void:

    if !active:
        return

    spawnTime -= delta


    if spawnTime <= 0:

        if activeAgents < spawnLimit:
            SpawnWanderer()

        spawnTime = easeSpawnTime()
        