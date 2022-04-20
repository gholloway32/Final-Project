extends Spatial
onready var PowerUp = preload("res://PowerUps/PocketWatch.tscn")
onready var Maze = get_node("/root/Game/Maze")
export var count = 10


func _ready():
	var locations = []
	for x in range(Maze.width-2):
		for z in range(Maze.height-2):
			locations.append(Vector3(((x+1)*Maze.tile)-1,0.1,((z+1)*Maze.tile)-1))
	locations.shuffle()
	for i in range(count):
			var powerup = PowerUp.instance()
			powerup.translate(locations[i])
			add_child(powerup)

