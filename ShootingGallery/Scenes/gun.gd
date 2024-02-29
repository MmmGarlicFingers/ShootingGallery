extends Node2D

@onready var ammo = $AmmoComponent
@onready var trigger = $TriggerComponent
var reloading = false
var ducking = false

signal update_ammo(ammo)
signal shoot

var bullet_scene = load("res://Scenes/Components/bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	update_ammo.emit(ammo.ammo)

func _on_trigger_component_pulled():
	if ammo.spend_ammo() and !reloading and !ducking:
		shoot.emit()
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		update_ammo.emit(ammo.ammo)

func _on_trigger_component_reload():
	reloading = true
	ammo.reload()

func _on_ammo_component_reloaded():
	reloading = false
	update_ammo.emit(ammo.ammo)

func _on_duck():
	ducking = true

func _on_unduck():
	ducking = false
