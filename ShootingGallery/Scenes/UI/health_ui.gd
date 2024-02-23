extends Button

var health = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	update_health()

func _on_health_component_damaged():
	health -= 1
	update_health()

func update_health():
	text = str(health)
