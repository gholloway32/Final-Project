extends Node

var menu = null
var time = 60
const SAVE_PATH = "res://settings.cfg"
var save_file = ConfigFile.new()
var inputs = ["left","right","forward","back"]

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	load_input()

func reset():
	get_tree().paused = false
	time = 60


func _unhandled_input(_event):
	if Input.is_action_just_pressed("menu"):
		var menu = get_node_or_null("/root/Game/UI/Menu")
		if menu != null:
			if not menu.visible:
				menu.show()
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				get_tree().paused = true
			else:
				save_input()
				menu.hide()
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				
				get_tree().paused = false


func load_input():
	var error = save_file.load(SAVE_PATH)
	if error != OK:
		print("Failed loading file")
		return
	
	for i in inputs:
		var key = save_file.get_value("Inputs", i, null)
		InputMap.action_erase_events(i)
		InputMap.action_add_event(i, key)

func save_input():
	for i in inputs:
		var actions = InputMap.get_action_list(i)
		for a in actions:
			save_file.set_value("Inputs", i, a)
	save_file.save(SAVE_PATH)

func update_time(t):
	time += t 
	if time <= 0:
		var _scene = get_tree().change_scene("res://UI/LoseTime.tscn")
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_time() 
