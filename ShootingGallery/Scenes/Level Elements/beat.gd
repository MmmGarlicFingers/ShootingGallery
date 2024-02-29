extends Control

@export var BPM: float = 60
@export var LIGHTS_BIN: String = "BBBB"
var MAX_BEATS
var timer
var interval
var lights = []
var cur_light = 0
var stopped = false
var colours = {
	"G": SignalBus.COLOURS.GREEN,
	"R": SignalBus.COLOURS.RED,
	"B": SignalBus.COLOURS.BLACK,
	"Y": SignalBus.COLOURS.YELLOW
}

# Called when the node enters the scene tree for the first time.
func _ready():
	MAX_BEATS = len(LIGHTS_BIN)
	SignalBus.connect("level_done", stop)
	
	interval = 60/BPM
	timer = $Timer
	timer.start(interval)
	
	var light_box = $Lights
	
	for i in MAX_BEATS:
		lights.append(load("res://Scenes/Level Elements/light.tscn").instantiate())
		lights[i].colour = colours[LIGHTS_BIN[i]]
		light_box.add_child(lights[i])
	
	lights[0].turn_on()
	
	
	


func _on_timer_timeout():
	SignalBus.beat.emit()
	SignalBus.stop.emit()
	lights[cur_light].turn_off()
	cur_light += 1
	if cur_light == MAX_BEATS:
		cur_light = 0
	SignalBus.go.emit(lights[cur_light].colour)
	if cur_light == 0:
		SignalBus.new_cycle.emit()
	if !stopped:
		lights[cur_light].turn_on()
	timer.start(interval)

func stop():
	stopped = true
