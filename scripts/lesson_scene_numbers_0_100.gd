extends Node2D

var lesson :ChooseFromNineLesson

@onready var lbl_query: Label = $MarginContainer/VBoxContainer/TextureRect/LabelQuery
@onready var lbl_progress: Label = $HBoxContainer/NinePatchRectProgress/LabelProgress
@onready var lbl_correct: Label = $HBoxContainer/NinePatchRectCorrect/LabelCorrect
@onready var lbl_wrong: Label = $HBoxContainer/NinePatchRectWrong/LabelWrong
@onready var btn_answer_0: Button = $MarginContainer/VBoxContainer/CentralContainer/GridContainer/NinePatchRect0/ButtonAnswer0
@onready var btn_answer_1: Button = $MarginContainer/VBoxContainer/CentralContainer/GridContainer/NinePatchRect1/ButtonAnswer1
@onready var btn_answer_2: Button = $MarginContainer/VBoxContainer/CentralContainer/GridContainer/NinePatchRect2/ButtonAnswer2
@onready var btn_answer_3: Button = $MarginContainer/VBoxContainer/CentralContainer/GridContainer/NinePatchRect3/ButtonAnswer3
@onready var btn_answer_4: Button = $MarginContainer/VBoxContainer/CentralContainer/GridContainer/NinePatchRect4/ButtonAnswer4
@onready var btn_answer_5: Button = $MarginContainer/VBoxContainer/CentralContainer/GridContainer/NinePatchRect5/ButtonAnswer5
@onready var btn_answer_6: Button = $MarginContainer/VBoxContainer/CentralContainer/GridContainer/NinePatchRect6/ButtonAnswer6
@onready var btn_answer_7: Button = $MarginContainer/VBoxContainer/CentralContainer/GridContainer/NinePatchRect7/ButtonAnswer7
@onready var btn_answer_8: Button = $MarginContainer/VBoxContainer/CentralContainer/GridContainer/NinePatchRect8/ButtonAnswer8
@onready var btn_exit: Button = $HBoxContainer/NinePatchRectExit/ButtonExit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(OS.get_data_dir())
	lesson = ChooseFromNineLesson.new(40, "Numbers 0-100", "numbers.1in9.en2ie", 9)
	print(str(lesson.steps))
	draw_step(lesson.current_step_number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func draw_step(step_num: int):
	if step_num >= lesson.steps.size():
		print("Lesson finished, opening summary")
		lesson_finished()
		return
		
	var step = lesson.steps[step_num]
	lbl_query.text = step["question"]
	btn_answer_0.text = step["choices"][0]
	btn_answer_1.text = step["choices"][1]
	btn_answer_2.text = step["choices"][2]
	btn_answer_3.text = step["choices"][3]
	btn_answer_4.text = step["choices"][4]
	btn_answer_5.text = step["choices"][5]
	btn_answer_6.text = step["choices"][6]
	btn_answer_7.text = step["choices"][7]
	btn_answer_8.text = step["choices"][8]
	lbl_progress.text = "Progress\n" + str(step_num) + "/"+ str(lesson.steps.size())
	var results := lesson.number_of_correct_and_wrong_answers()
	lbl_correct.text = "Correct\n" + str(results[StepStatus.CORRECT])
	lbl_wrong.text = "Wrong\n" + str(results[StepStatus.WRONG])
	btn_exit.icon = load("res://assets/icon/arrowLeft.png")
	scale_component(lbl_progress, 1.0)
	scale_component(lbl_correct, 1.0)
	scale_component(lbl_wrong, 1.0)
	get_viewport().gui_release_focus()


func process_answer(step_num: int, option_chosen: String):
	if step_num >= lesson.steps.size():
		print("Lesson finished, nothing to process")
		return

	var step = lesson.steps[step_num]
	step["chosen"] = option_chosen
	var result := lesson.steps[lesson.current_step_number].check_choice()
	scale_component(lbl_progress, 1.1)
	if result > 0:
		$AudioCorrect.play()
		btn_exit.icon = load("res://assets/icon/face_a.png")
		scale_component(lbl_correct, 1.1)
	else:
		$AudioWrong.play()
		btn_exit.icon = load("res://assets/icon/face_i.png")
		scale_component(lbl_wrong, 1.1)
	lesson.current_step_number += 1

func scale_component(component: Control, scale: float) -> void:
	component.scale.x = scale
	component.scale.y = component.scale.x
	component.pivot_offset.x = component.size.x/2
	component.pivot_offset.y = component.size.y/2


func lesson_finished():
	Global.current_results = lesson.steps
	Global.goto_scene("res://scene/lesson_finish_scene.tscn")


func _on_button_answer_0_pressed() -> void:
	process_answer(lesson.current_step_number, btn_answer_0.text)


func _on_button_answer_1_pressed() -> void:
	process_answer(lesson.current_step_number, btn_answer_1.text)


func _on_button_answer_2_pressed() -> void:
	process_answer(lesson.current_step_number, btn_answer_2.text)


func _on_button_answer_3_pressed() -> void:
	process_answer(lesson.current_step_number, btn_answer_3.text)


func _on_button_answer_4_pressed() -> void:
	process_answer(lesson.current_step_number, btn_answer_4.text)


func _on_button_answer_5_pressed() -> void:
	process_answer(lesson.current_step_number, btn_answer_5.text)


func _on_button_answer_6_pressed() -> void:
	process_answer(lesson.current_step_number, btn_answer_6.text)


func _on_button_answer_7_pressed() -> void:
	process_answer(lesson.current_step_number, btn_answer_7.text)


func _on_button_answer_8_pressed() -> void:
	process_answer(lesson.current_step_number, btn_answer_8.text)


func _on_button_exit_pressed() -> void:
	#get_tree().change_scene_to_file("res://scene/main_menu_scene.tscn")
	Global.goto_scene("res://scene/main_menu_scene.tscn")


func _on_audio_correct_finished() -> void:
	draw_step(lesson.current_step_number)


func _on_audio_wrong_finished() -> void:
	draw_step(lesson.current_step_number)
