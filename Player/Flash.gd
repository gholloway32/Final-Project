extends Spatial

func shoot():
	show()
	var sound = get_node_or_null("/root/Game/Gunshot")
	sound.playing = true
	$Timer.start()
func _on_Timer_timeout():
	hide()
