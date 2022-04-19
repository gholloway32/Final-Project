extends KinematicBody

onready var camera = $Pivot/Camera

var speed = 8
var gravity = -500
var mouse_sensitivity = 0.002
var mouse_range = 1.2
var velocity = Vector3.ZERO
onready var rc = $Pivot/RayCast
onready var flash = $Pivot/blasterE/Flash
onready var Decal = preload("res://Player/Decal.tscn")

func _ready():
	camera.current = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	velocity.y +=gravity * delta
	var desired_velocity = get_input() *speed
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true) 
	velocity = get_input()*speed
	
	if Input.is_action_just_pressed("shoot") and !flash.visible:
		flash.shoot()
		if rc.is_colliding():
			var c = rc.get_collider()
			var decal = Decal.instance()
			rc.get_collider().add_child(decal)
			decal.global_transform.origin = rc.get_collision_point()
			decal.look_at(rc.get_collision_point()+rc.get_collision_normal(),Vector3.UP)
			if c.is_in_group("Enemy"):
				c.queue_free()
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)


func die():
	rpc_unreliable("_die")
	queue_free()

func get_input():
	var input_dir = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		input_dir += -camera.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += camera.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir
