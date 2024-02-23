extends Node2D

@export var cycles: bool = true
@export var spawn_interval: int = 2 #Interval in cycles
@export var path_loops: bool = true
@export var dest_path: NodePath # we assign a path using inspector
@onready var destination := get_node(dest_path) as Node2D # then we get a reference

var beat

func _ready():
	SignalBus.connect("new_cycle", on_cycle)
	beat = spawn_interval

func on_cycle():
	if cycles:
		beat -= 1
		if beat == 0:
			spawn_enemy()
			beat = spawn_interval

func spawn_enemy():
	var enemy_scene = load("./Scenes/enemy.tscn")
	var enemy = enemy_scene.instantiate()
	var path = PathFollow2D.new()
	
	destination.add_child(path)
	path.set_script(load("./Scenes/Level Elements/enemy_path.gd"))
	path.rotates = false
	path.rotation_degrees = 0
	path.set_process(true)
	if !path_loops:
		path.loops = false
	
	path.add_child(enemy)
	return enemy
