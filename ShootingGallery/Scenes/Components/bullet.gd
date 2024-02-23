extends Node2D

@onready var area = $Area2D
@onready var area_timer = $AreaTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	area_timer.start(0.1)
	position = get_global_mouse_position()

func _on_area_timer_timeout():
	queue_free()
