extends Node2D

@onready var spawner = $Spawner
@export var row_count: int = 1
var cur_beat_colour
var spawned = false
@export var colour: SignalBus.COLOURS

func _ready():
	SignalBus.connect("go", _on_go)
	SignalBus.connect("new_cycle", _on_new_cycle)

func _spawn():
	row_count -= 1
	if row_count == 0:
		var enemy = spawner.spawn_enemy(colour)
		enemy.shoot_countdown(colour)
		enemy.shoot_countdown(colour)
		spawned = true

func _on_go(beat_colour):
	cur_beat_colour = beat_colour

func _on_new_cycle():
	if $Path2D.get_child_count() == 0 and spawned:
		SignalBus.level_done.emit()
		spawned = false
