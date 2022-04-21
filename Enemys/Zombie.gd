extends KinematicBody

var Player = null


func _ready():
	pass

func _physics_process(_delta):
	if Player == null:
		Player = get_node_or_null("/root/Game/Player")
		if Player != null:
			look_at(Player.global_transform.origin, Vector3.UP)
	#if not $Tween.is_active():
	#	$Tween.interpolate_property(self, "translation", translation, Vector3(randf()*2, randf()*1, randf()*2), 3.0, Tween.TRANS_CIRC, Tween.EASE_IN_OUT, 1.0)
	#	$Tween.start()

func _on_Area_body_entered(body):
	if body.name == "Player":
		var sound = get_node_or_null("/root/Game/Zombie")
		sound.playing = true


func _on_Kill_body_entered(body):
	if body.name == "Player":
		var _scene = get_tree().change_scene("res://UI/Lose.tscn")
