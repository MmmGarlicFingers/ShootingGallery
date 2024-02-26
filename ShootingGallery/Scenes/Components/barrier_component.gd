extends Node2D

@onready var sprite = $Sprite2D
@onready var anim_player = $Sprite2D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.position.y = 360

func _duck():
	anim_player.play("Duck")
	
func _unduck():
	anim_player.play_backwards("Duck")
