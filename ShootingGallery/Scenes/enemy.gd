extends Node2D

var health
var gun
var vulnerable = false
var colour #To be compared to signal bus's COLOURS enum

# Called when the node enters the scene tree for the first time.
func _ready():
	health = $HealthComponent
	gun = $ShootComponent
	
	SignalBus.connect("go", shoot_countdown)
	SignalBus.connect("stop", set_vulnerable_false)

func shoot_countdown(light_colour):
	if light_colour == colour:
		gun.countdown()
		vulnerable = true
	if gun.count == 1:
		$Sprite2D.texture = load("res://Scenes/textures/duck.tres")


func _on_hitbox_component_hit():
	if vulnerable:
		health.damage(1)


func _on_health_component_dead():
	if $ShootComponent.count == 0:
		SignalBus.score_add.emit("Honourable")
	else:
		SignalBus.score_add.emit("Kill")
	get_parent().queue_free()
	queue_free()


func _on_shoot_component_shoot():
	SignalBus.enemy_shoot.emit()
	$Sprite2D.texture = load("res://Scenes/textures/duck_shoot.tres")
	$PointLight2D.enabled = true
	$ShootEffectTimer.start(0.1)


func _on_hitbox_component_suppressed():
	gun.reset()
	$Sprite2D.texture = load("res://Scenes/textures/duck_side.tres")
	pass


func _on_shoot_effect_timer_timeout():
	$Sprite2D.texture = load("res://Scenes/textures/duck_side.tres")
	$PointLight2D.enabled = false

func set_vulnerable_true():
	vulnerable = true

func set_vulnerable_false():
	vulnerable = false

func set_colour(new_colour): #Must take in a Signal Bus COLOURS
	colour = new_colour
	match colour:
		SignalBus.COLOURS.GREEN:
			$Sprite2D.material = preload("res://Shaders/green.tres")
		SignalBus.COLOURS.RED:
			$Sprite2D.material = preload("res://Shaders/red.tres")
		SignalBus.COLOURS.YELLOW:
			$Sprite2D.material = null
