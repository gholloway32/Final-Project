extends Spatial

const N = 1 					# binary 0001
const E = 2 					# binary 0010
const S = 4 					# binary 0100
const W = 8 					# binary 1000

var cell_walls = {
	Vector2(0, -1): N, 			# cardinal directions for NESW
	Vector2(1, 0): E,
	Vector2(0, 1): S, 
	Vector2(-1, 0): W
}

var map = []

var tiles = [
	preload("res://Tiles/Tile00.tscn")	# all the tiles we created
	,preload("res://Tiles/Tile1.tscn")
	,preload("res://Tiles/Tile2.tscn")
	,preload("res://Tiles/Tile3.tscn")
	,preload("res://Tiles/Tile4.tscn")
	,preload("res://Tiles/Tile5.tscn")
	,preload("res://Tiles/Tile6.tscn")
	,preload("res://Tiles/Tile7.tscn")
	,preload("res://Tiles/Tile8.tscn")
	,preload("res://Tiles/Tile9.tscn")
	,preload("res://Tiles/Tile10.tscn")
	,preload("res://Tiles/Tile11.tscn")
	,preload("res://Tiles/Tile12.tscn")
	,preload("res://Tiles/Tile13.tscn")
	,preload("res://Tiles/Tile14.tscn")
	,preload("res://Tiles/Tile15.tscn")
]

var tile = 2 						# 2-meter tiles
var width = 20  						# width of map (in tiles)
var height = 10  						# height of map (in tiles)
var tile_size = Vector2.ZERO

onready var Key = preload("res://Key/key.tscn")
onready var Exit = preload("res://Exit/Exit.tscn")

func _ready():
	randomize()
	make_maze()
	var key = Key.instance()
	key.translate(Vector3((width*tile)-1.5,1
	,0.5))
	add_child(key)
	print(key.global_transform.origin)
	var exit = Exit.instance()
	exit.translate(Vector3((width*tile)-1.5,0.1,(height*tile)-1.5))
	add_child(exit)
	print(exit.global_transform.origin)
	
func check_neighbors(cell, unvisited):
	# returns an array of cell's unvisited neighbors
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited:
			list.append(cell + n)
	return list
	
func make_maze():
	var unvisited = []  # array of unvisited tiles
	var stack = []
	# fill the map with solid tiles
	for x in range(width):
		map.append([])
		map[x].resize(height)
		for y in range(height):
			unvisited.append(Vector2(x, y))
			map[x][y] = N|E|S|W 		# 15
	var current = Vector2(0, 0)
	unvisited.erase(current)
	while unvisited:
		var neighbors = check_neighbors(current, unvisited)
		if neighbors.size() > 0:
			var next = neighbors[randi() % neighbors.size()]
			stack.append(current)
			var dir = next - current
			var current_walls = map[current.x][current.y] - cell_walls[dir]
			var next_walls = map[next.x][next.y] - cell_walls[-dir]
			map[current.x][current.y] = current_walls
			map[next.x][next.y] = next_walls
			current = next
			unvisited.erase(current)
		elif stack:
			current = stack.pop_back()
	for x in range(width):
		for z in range(height):
			var t = tiles[map[x][z]].instance()
			t.translate(Vector3(x,0,z)*tile)
			t.name = "Tile_" + str(x) + "_" + str(z)
			add_child(t)
