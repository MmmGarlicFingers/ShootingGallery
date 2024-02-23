extends PathFollow2D

var speed = 100 #px per second
var loops = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += speed * delta
	if !loops:
		if progress_ratio >= 0.97:
			progress_ratio = 1.0
			set_process(false)
