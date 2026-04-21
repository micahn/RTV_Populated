extends Node

func _ready():
	overrideScript("res://RTV_Populated/AISpawner.gd")
	overrideScript("res://RTV_Populated/HUD.gd")
	if get_tree().current_scene != null:
		get_tree().reload_current_scene()
	queue_free()

func overrideScript(overrideScriptPath: String):
	var script: Script = load(overrideScriptPath)
	script.reload()
	var parentScript = script.get_base_script()
	script.take_over_path(parentScript.resource_path)
	return script
