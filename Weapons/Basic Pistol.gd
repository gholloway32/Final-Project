extends Spatial
onready var rc = $RayCast
onready var flash = $Flash
onready var timer = $Flash/Timer
onready var decal = preload("res://Player/Decal.tscn")
func _ready():
	pass



func shoot():
	if not flash.visible:
		flash.show()
		timer.start()
		if rc.is_colliding():
			var t = rc.get_collider()
			var p = rc.get_collision_point()
			var n = rc.get_collision_normal()
			t.add_child(decal)
			decal.global_transform.origin = p
			decal.look_at(p + n, Vector3.UP)


func _on_Timer_timeout():
	flash.hide()
