extends Button
@export_file var level_path


func _on_pressed():
	if level_path == null:
		LevelData.cur_level += 1
		get_tree().change_scene_to_file(LevelData.levels[LevelData.cur_level].path)
	else:
		get_tree().change_scene_to_file(level_path)
