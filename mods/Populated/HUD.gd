
extends "res://Scripts/HUD.gd"

var showDebug : bool = false
var AI

func _load_new_config(config: ConfigFile):
    showDebug = config.get_value("Bool", "showDebug").value

func _ready():
    super()
    var PC = get_tree().root.get_node("ModLoader/PopulatedConfig")
    showDebug = PC._config.get_value("Bool", "showDebug").value
    PC.configChanged.connect(_load_new_config)
    AI = get_tree().root.get_node_or_null("/root/Map/AI")
    

func _process(delta: float):
    if showDebug:
        if AI:
            map.text = map.text.get_slice(" --[",0) + str(" --[" + str(AI.activeAgents) + "/" + str(AI.spawnLimit) + "/" + str(AI.activeAgents + AI.APool.get_child_count()) + str(" %0.2f" % AI.spawnTime) + "]")
        else:
            map.text = map.text.get_slice(" --[",0) + " --[ NO AI ]"
    else:
        map.text = map.text.get_slice(" --[",0)

