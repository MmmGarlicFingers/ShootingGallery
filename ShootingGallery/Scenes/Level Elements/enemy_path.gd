extends PathFollow2D

var speed = 100 #px per second
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += speed * delta
