extends Spatial
onready var rc = $RayCast
onready var rc2 = $RayCast2 
onready var rc3 = $RayCast3
onready var flash = $Flash
onready var timer = $Flash/Timer
onready var Decal = load("res://Player/Decal.tscn")
onready var Pickup = load("res://Guns/Shotgun.tscn")


func _ready():
	pass


func shoot():
	if not flash.visible:
		flash.show()
		var sound = get_node_or_null("/root/Game/Gunshot")
		sound.playing = true
		timer.start()
		if rc.is_colliding():
			var t = rc.get_collider()
			var p = rc.get_collision_point()
			var n = rc.get_collision_normal()
			var decal = Decal.instance()
			t.add_child(decal)
			decal.global_transform.origin = p
			decal.look_at(p + n, Vector3.UP)
			if t.is_in_group("Enemy"):
				t.queue_free()
		if rc2.is_colliding():
			var t = rc.get_collider()
			var p = rc.get_collision_point()
			var n = rc.get_collision_normal()
			var decal = Decal.instance()
			decal.global_transform.origin = p
			decal.look_at(p + n, Vector3.UP)
			if t.is_in_group("Enemy"):
				t.queue_free()
		if rc3.is_colliding():
			var t = rc.get_collider()
			var p = rc.get_collision_point()
			var n = rc.get_collision_normal()
			var decal = Decal.instance()
			decal.global_transform.origin = p
			decal.look_at(p + n, Vector3.UP)
			if t.is_in_group("Enemy"):
				t.queue_free()

func _on_Timer_timeout():
	flash.hide()
