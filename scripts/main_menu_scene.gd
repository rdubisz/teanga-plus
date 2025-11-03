extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioWelcome.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#	Global.current_lesson = Lesson1in9.new(10, "Numbers 1-10", "numbers.1in9.en2ie", 9, 10)
#   Global.current_lesson = Lesson1in9.new(40, "Numbers 0-100", "numbers.1in9.en2ie", 9)
#   Global.current_lesson = Lesson1in9.new(10, "Pronouns", "pronouns.1in9.ie2en", 9)
#	get_tree().change_scene_to_file("res://scene/lesson_1in9_scene.tscn")
	

func _on_btn_exit_pressed() -> void:
	$AudioExit.play()


func _on_audio_exit_finished() -> void:
	get_tree().quit()


func _on_btn_lesson_numbers_one_to_ten_to_ie_pressed() -> void:
	Global.current_lesson = Lesson1in9.new(20, "Numbers 1-10", "numbers.1in9.en2ie", 9, 10)
	get_tree().change_scene_to_file("res://scene/lesson_1in9_scene.tscn")


func _on_btn_lesson_numbers_one_to_ten_to_digit_pressed() -> void:
	Global.current_lesson = Lesson1in9.new(20, "Numbers 1-10", "numbers.1in9.en2ie", 9, 10)
	get_tree().change_scene_to_file("res://scene/lesson_1in9_scene.tscn")


func _on_btn_lesson_numbers_zero_to_hundred_to_ie_pressed() -> void:
	Global.current_lesson = Lesson1in9.new(40, "Numbers 0-100", "numbers.1in9.en2ie", 9)
	get_tree().change_scene_to_file("res://scene/lesson_1in9_scene.tscn")


func _on_btn_lesson_numbers_zero_to_hundred_to_digit_pressed() -> void:
	Global.current_lesson = Lesson1in9.new(40, "Numbers 0-100", "numbers.1in9.ie2en", 9)
	get_tree().change_scene_to_file("res://scene/lesson_1in9_scene.tscn")


func _on_bt_lesson_subject_pronouns_to_ie_pressed() -> void:
	Global.current_lesson = Lesson1in9.new(20, "Pronouns", "pronouns.1in9.en2ie", 9)
	get_tree().change_scene_to_file("res://scene/lesson_1in9_scene.tscn")


func _on_bt_lesson_subject_pronouns_to_en_pressed() -> void:
	Global.current_lesson = Lesson1in9.new(20, "Pronouns", "pronouns.1in9.ie2en", 9)
	get_tree().change_scene_to_file("res://scene/lesson_1in9_scene.tscn")
