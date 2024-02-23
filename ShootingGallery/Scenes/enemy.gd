extends Node2D

var health
var gun

# Called when the node enters the scene tree for the first time.
func _ready():
	health = $HealthComponent
	gun = $ShootComponent
	
	SignalBus.connect("go", shoot_countdown)

func shoot_countdown():
	gun.countdown()


func _on_hitbox_component_hit():
	health.damage(1)


func _on_health_component_dead():
	get_parent().queue_free()
	queue_free()


func _on_shoot_component_shoot():
	SignalBus.enemy_shoot.emit()


func _on_hitbox_component_suppressed():
	#gun.reset()
	pass
