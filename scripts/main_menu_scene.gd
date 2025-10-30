extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioWelcome.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_lesson_numbers_one_to_ten_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/lesson_scene_numbers_1_10.tscn")


func _on_btn_lesson_numbers_zero_to_hundred_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/lesson_scene_numbers_0_100.tscn")


func _on_bt_lesson_subject_pronouns_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/lesson_scene_subject_pronouns.tscn")


func _on_btn_exit_pressed() -> void:
	$AudioExit.play()


func _on_audio_exit_finished() -> void:
	get_tree().quit()
