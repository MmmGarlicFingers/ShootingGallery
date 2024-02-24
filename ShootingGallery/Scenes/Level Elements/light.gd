extends Control

@export var shoot: bool = false
var image
@onready var light = $PointLight2D

# Called when the node enters the scene tree for the first time.
func _ready():
	image = $TextureRect
	
	

func turn_on():
	light.enabled = true
	image.texture = preload("res://assets/light_on.png")
	if shoot:
		light.color = Color.GREEN
	else:
		light.color = Color.RED

func turn_off():
	image.texture = preload("res://assets/light_off.png")
	light.enabled = false
