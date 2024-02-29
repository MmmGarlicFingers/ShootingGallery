extends Node2D

@export var sequence: String = "00"
var cur_enemy = 0
var spawner

signal done

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("new_cycle", new_cycle)
	new_cycle()

func new_cycle():
	if cur_enemy >= len(sequence):
		if get_num_enemies() <= 0:
			done.emit()
			SignalBus.disconnect("new_cycle", new_cycle)
	else:
		var spawn_num = 0
		var spawn_colour = null
		while true:
			match sequence[cur_enemy]: #Ghetto fallthrough
				"0":
					break
				" ":
					if get_num_enemies() < 1:
						cur_enemy += 1
						continue
					else:
						return
				"2":
					spawn_num = 2
					cur_enemy += 1
					continue 
				"3":
					spawn_num = 3
					cur_enemy += 1
					continue 
				"Y":
					spawn_colour = SignalBus.COLOURS.YELLOW
				"G":
					spawn_colour = SignalBus.COLOURS.GREEN
				"R":
					spawn_colour = SignalBus.COLOURS.RED

			if spawn_colour != null:
				if spawn_num == 0:
					spawn_num = 1
				break

		for i in range(spawn_num):
			choose_spawner()
			spawner.spawn_enemy(spawn_colour)

	cur_enemy += 1

func choose_spawner():
	while true: #This makes sure that two ducks won't be placed in the same static path
		var spawner_list = $Spawners.get_children()
		spawner = spawner_list.pick_random()
		var dest_node = spawner.destination
		if dest_node.get_child_count() > 0:
			continue
		else:
			break
		

func get_num_enemies():
	var num = 0
	for path in $Paths.get_children():
		num += path.get_child_count()
	return num
