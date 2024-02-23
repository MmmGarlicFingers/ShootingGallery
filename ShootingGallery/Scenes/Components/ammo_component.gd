extends Node2D

@export var MAX_AMMO: int = 6
@export var RELOAD_TIME: float = 0.5
@onready var ammo = MAX_AMMO
@onready var timer = $Timer

var empty = false

signal reloaded
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spend_ammo():
	if !empty:
		ammo -= 1
		if ammo <= 0:
			empty = true
		return true
	else:
		return false

func reload():
	timer.start(RELOAD_TIME)

func _on_timer_timeout():
	ammo = MAX_AMMO
	empty = false
	reloaded.emit()
