extends Node2D

@onready var ammo = $AmmoComponent
@onready var trigger = $TriggerComponent

signal update_ammo(ammo)

var bullet_scene = load("res://Scenes/Components/bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	update_ammo.emit(ammo.ammo)

func _on_trigger_component_pulled():
	if ammo.spend_ammo():
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		update_ammo.emit(ammo.ammo)
		


func _on_trigger_component_reload():
	ammo.reload()


func _on_ammo_component_reloaded():
	update_ammo.emit(ammo.ammo)
