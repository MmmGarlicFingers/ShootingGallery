extends Control

var health #Reference to health component
var ducking = false #If ducking from enemy fire, true
var iFrame = false #invinciblity frames
var input_disabled = false

signal duck
signal unduck
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("enemy_shoot", shot)	#recieve enemy shots in shot()
	SignalBus.connect("level_done", _finish_level)
	health = $HealthComponent

func _process(_delta):
	#Ducking
	if !input_disabled:
		if Input.is_action_just_pressed("space"):
			_on_duck_button_down()
		elif Input.is_action_just_released("space"):
			_on_duck_button_up()


func shot():
	if !ducking and !iFrame:
		health.damage(1)
		iFrame = true
		$InvincibilityTimer.start(1)

func die():
	input_disabled = true
	_on_duck_button_down()
	var death_scene_path = load("./Scenes/UI/death_scene.tscn")
	var death_scene = death_scene_path.instantiate()
	add_child(death_scene)

#Activated both by pressing space and ducking button
func _on_duck_button_down():
	duck.emit()
	ducking = true


func _on_duck_button_up():
	unduck.emit()
	ducking = false


func _on_invincibility_timer_timeout():
	iFrame = false

func _finish_level():
	input_disabled = true
	_on_duck_button_down()
