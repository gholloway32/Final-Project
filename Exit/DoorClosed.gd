extends Area

var locked = true

func _ready():
	pass


func unlocked():
	locked = false 
	

func _on_Exit_body_entered(body):
	if body.name == "Player" and not locked:
		var _scene = get_tree().change_scene("res://UI/Win.tscn")
		
