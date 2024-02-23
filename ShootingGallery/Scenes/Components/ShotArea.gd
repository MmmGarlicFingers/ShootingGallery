extends Area2D

signal hit
@export var blocks_shots: bool = false
@export var displays_bullet_hole: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)

func _on_area_entered(_area):
	hit.emit()
	if displays_bullet_hole:
		var sprite = Sprite2D.new()
		sprite.texture = load("res://assets/bullet_hole.png")
		add_child(sprite)
		sprite.position = get_local_mouse_position()
