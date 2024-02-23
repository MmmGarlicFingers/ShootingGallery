extends Node2D

@export var dest_path: NodePath # we assign a path using inspector
@onready var hitbox := get_node(dest_path) as Node2D # then we get a reference
@onready var shot_area = $ShotArea

@export var blocks_shots: bool = false

var vulnerable = false

signal hit
signal suppressed

func _ready():
	SignalBus.connect("go", set_vulnerable)
	SignalBus.connect("stop", set_not_vulnerable)
	$ShotArea.blocks_shots = blocks_shots
	remove_child(hitbox)
	shot_area.add_child(hitbox)

func on_hit():
	if vulnerable:
		hit.emit()

func on_suppressed():
	suppressed.emit()

func set_vulnerable():
	vulnerable = true

func set_not_vulnerable():
	vulnerable = false
