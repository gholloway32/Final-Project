extends Area


func _on_PocketWatch_body_entered(body):
	if body.name == "Player":
		var sound = get_node_or_null("/root/Game/Clock")
		if sound != null:
			sound.playing = true
		Global.update_time(5)
		queue_free()
