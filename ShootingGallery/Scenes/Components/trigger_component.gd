extends Node2D

signal pulled
signal reload

var disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		if !disabled:
			pulled.emit()
	if event.is_action_pressed("reload"):
		reload.emit()
