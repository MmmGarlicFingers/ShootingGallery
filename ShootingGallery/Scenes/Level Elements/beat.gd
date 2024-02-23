extends Control

@export var BPM: float = 60
@export var LIGHTS_BIN: String = "0001"
var MAX_BEATS
var timer
var interval
var lights = []
var cur_light = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	MAX_BEATS = len(LIGHTS_BIN)
	
	interval = 60/BPM
	timer = $Timer
	timer.start(interval)
	
	var light_box = $Lights
	
	for i in MAX_BEATS:
		lights.append(load("res://Scenes/Level Elements/light.tscn").instantiate())
		if LIGHTS_BIN[i] == "1":
			lights[i].shoot = true
		light_box.add_child(lights[i])
	
	lights[0].turn_on()
	
	
	


func _on_timer_timeout():
	SignalBus.beat.emit()
	lights[cur_light].turn_off()
	cur_light += 1
	if cur_light == MAX_BEATS:
		cur_light = 0
		SignalBus.new_cycle.emit()
	lights[cur_light].turn_on()
	if lights[cur_light].shoot:
		SignalBus.go.emit()
	else:
		SignalBus.stop.emit()
	timer.start(interval)
