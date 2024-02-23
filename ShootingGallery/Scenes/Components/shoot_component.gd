extends Node2D

signal shoot
@export var MAX_COUNT: int = 3
@export var delay: float = 0.1
var count = MAX_COUNT
var label
var timer
# Called when the node enters the scene tree for the first time.
func _ready():
	label = $Label
	timer = $ShootTimer
	label.text = str(count)
	
func countdown():
	count -= 1
	if count == 0:
		timer.start(delay)
		reset()
	label.text = str(count)

func reset():
	count = MAX_COUNT
	label.text = str(count)

func shoot_gun():
	shoot.emit()
	
