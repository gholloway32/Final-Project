extends KinematicBody

onready var camera = $Pivot/Camera

var speed = 8
var gravity = -500
var mouse_sensitivity = 0.002
var mouse_range = 1.2
var velocity = Vector3.ZERO

var to_pickup = null

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
	if Input.is_action_pressed("shoot"):
		shoot()
	
	if Input.is_action_just_pressed("pickup"):
		pickup()
	
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

func shoot():
	var gun = get_node_or_null("Pivot/Gun")
	if gun != null and gun.has_method("shoot"):
		gun.shoot()

func pickup():
	var gun = get_node_or_null("Pivot/Gun")
	if gun != null:
		pass
	elif to_pickup != null:
		gun = to_pickup.Pickup.instance()
		gun.name == "Gun"
		$Pivot.add_child(gun)
		to_pickup.queue_free()

func _on_Area_body_entered(body):
	if body.is_in_group("Guns"):
		to_pickup = body 


func _on_Area_body_exited(body):
	to_pickup = null
