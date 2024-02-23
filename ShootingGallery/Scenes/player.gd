extends Control

var health #Reference to health component
var ducking = false #If ducking from enemy fire, true
var iFrame = false #invinciblity frames

signal duck
signal unduck
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("enemy_shoot", shot)	#recieve enemy shots in shot()
	health = $HealthComponent

func _process(_delta):
	#Ducking
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
	queue_free()

#Activated both by pressing space and ducking button
func _on_duck_button_down():
	duck.emit()
	ducking = true


func _on_duck_button_up():
	unduck.emit()
	ducking = false


func _on_invincibility_timer_timeout():
	iFrame = false
