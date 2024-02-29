extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= 100 * delta
	modulate.a -= 1 * delta

func set_text(reason, score):
	$HFlowContainer/Label.text = reason
	if int(score) != 0:
		$HFlowContainer/Label2.text = score
