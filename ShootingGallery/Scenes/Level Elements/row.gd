extends Node2D

@export var sequence: String = "000"
var cur_enemy = 0
var spawner
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("new_cycle", new_cycle)
	new_cycle()

func new_cycle():
	choose_spawner()
	
	if cur_enemy >= len(sequence):
		pass
	else:
		if sequence[cur_enemy] == " ":
			if get_num_enemies() < 1:
				cur_enemy += 1
			else:
				return
		if sequence[cur_enemy] == "1":
			spawner.spawn_enemy()
		elif sequence[cur_enemy] == "2":
			spawner.spawn_enemy()
			choose_spawner()
			spawner.spawn_enemy()
			

	cur_enemy += 1

func choose_spawner():
	var spawner_list = $Spawners.get_children()
	spawner = spawner_list.pick_random()

func get_num_enemies():
	var num = 0
	for path in $Paths.get_children():
		num += path.get_child_count()
	return num
