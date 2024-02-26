extends RichTextLabel
var score = 0

func _ready():
	SignalBus.connect("score_add", add_score)

func add_score(amount):
	score += amount
	update()

func update():
	text = "[center]" + str(score)
	$AnimationPlayer.play("score")
