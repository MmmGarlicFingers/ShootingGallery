extends Control

@export var shoot: bool = false
var image

# Called when the node enters the scene tree for the first time.
func _ready():
	image = $TextureRect

func turn_on():
	if shoot:
		image.texture = load("./assets/light_shoot.png")
	else:
		image.texture = load("./assets/light_no_shoot.png")

func turn_off():
	image.texture = load("./assets/light_off.png")
