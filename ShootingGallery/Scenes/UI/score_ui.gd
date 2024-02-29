extends RichTextLabel
var score = 0
var target_score = 0
var multi_score = 0
var shots_taken = 0
var enemies_killed = 0
var not_shot_bonus = true
var time_bonus = false
var done = false
var score_reward = preload("res://Scenes/UI/score_reward.tscn")

signal turn_on_final_screen

func _ready():
	SignalBus.connect("score_add", add_score)
	SignalBus.connect("level_done", end_sequence)
	SignalBus.connect("beat", new_beat)

func _process(_delta):
	if score < target_score:
		score += 5
	if score > target_score:
		score = target_score
	if score == target_score and done:
		turn_on_final_screen.emit()
	update()
	
func add_score(reason):
	var amount = 0
	match reason:
		"Kill":
			amount = 100
			multi_score += 1
			amount *= multi_score
			if multi_score > 1:
				reason = "Multi-Kill"
			enemies_killed += 1
		"Honourable":
			amount = 200
			multi_score += 1
			amount *= multi_score
			enemies_killed += 1
		"Damageless":
			amount = 1000
		"Accuracy":
			var percent = int(float(enemies_killed)/float(shots_taken)*100)
			if percent == 100:
				amount = 1000
			elif percent >= 95:
				amount = 500
			elif percent >= 90:
				amount = 300
			elif percent > 70:
				amount = 100

	if time_bonus:
		amount += 100
		reason += " + Good Timing"
	
	var reward_instance = score_reward.instantiate()
	reward_instance.set_text(reason, "+" + str(amount))
	target_score += amount
	add_child(reward_instance)
	update()

func update():
	text = "[center]" + str(score)

func new_beat():
	multi_score = 0
	time_bonus = true
	$ScoreTimer.start(0.1)


func _on_score_timer_timeout():
	time_bonus = false

func end_sequence():
	await get_tree().create_timer(1).timeout
	if not_shot_bonus:
		add_score("Damageless")
	else:
		add_score("No Damageless Bonus")
	await get_tree().create_timer(1).timeout
	add_score("Accuracy")
	await get_tree().create_timer(0.5).timeout
	add_score(str(int((float(enemies_killed)/float(shots_taken))*100.0)) + "%")
	await get_tree().create_timer(1).timeout
	add_score("Grand Total")
	await get_tree().create_timer(0.5).timeout
	add_score(str(target_score))
	done = true
	
	

func _on_gun_shoot():
	shots_taken += 1

func _on_health_component_damaged():
	not_shot_bonus = false
