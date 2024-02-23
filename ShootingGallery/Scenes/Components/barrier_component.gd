extends Node2D

@onready var sprite = $Sprite2D
@onready var anim_player = $Sprite2D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _duck():
	anim_player.play("Duck")
	
func _unduck():
	anim_player.play_backwards("Duck")
