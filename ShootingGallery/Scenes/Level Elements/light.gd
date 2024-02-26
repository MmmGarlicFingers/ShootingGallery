extends Control

@export var shoot: bool = false
var image
@onready var light = $PointLight2D
var colours = {
	SignalBus.COLOURS.BLACK : Color.BLACK,
	SignalBus.COLOURS.YELLOW : Color.YELLOW,
	SignalBus.COLOURS.GREEN : Color.GREEN,
	SignalBus.COLOURS.RED : Color.RED,
}
var colour #To be compared to signal bus's COLOURS enum
# Called when the node enters the scene tree for the first time.
func _ready():
	image = $TextureRect
	light.color = colours[colour]
	
	

func turn_on():
	light.enabled = true
	image.texture = preload("res://assets/light_on.png")
		

func turn_off():
	image.texture = preload("res://assets/light_off.png")
	light.enabled = false
