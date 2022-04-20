extends Area


func _on_PocketWatch_body_entered(body):
	if body.name == "Player":
		Global.time += 5
		queue_free()
