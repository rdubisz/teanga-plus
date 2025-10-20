extends Control

var lesson :ChooseFromNineLesson

@onready var lbl_query: RichTextLabel = $MarginOuter/VBoxOuter/MarginQueryRow/LabelQuery
@onready var lbl_remaining: Label = $MarginOuter/VBoxOuter/MarginStatsRow/HBoxStatsRow/TextureRectRemaining/LabelRemaining
@onready var lbl_correct: Label = $MarginOuter/VBoxOuter/MarginStatsRow/HBoxStatsRow/TextureRectCorrect/LabelCorrect
@onready var lbl_wrong: Label = $MarginOuter/VBoxOuter/MarginStatsRow/HBoxStatsRow/TextureRectWrong/LabelWrong
@onready var btn_answer_0: Button = $MarginOuter/VBoxOuter/MarginChoices/Grid/ButtonAnswer0
@onready var btn_answer_1: Button = $MarginOuter/VBoxOuter/MarginChoices/Grid/ButtonAnswer1
@onready var btn_answer_2: Button = $MarginOuter/VBoxOuter/MarginChoices/Grid/ButtonAnswer2
@onready var btn_answer_3: Button = $MarginOuter/VBoxOuter/MarginChoices/Grid/ButtonAnswer3
@onready var btn_answer_4: Button = $MarginOuter/VBoxOuter/MarginChoices/Grid/ButtonAnswer4
@onready var btn_answer_5: Button = $MarginOuter/VBoxOuter/MarginChoices/Grid/ButtonAnswer5
@onready var btn_answer_6: Button = $MarginOuter/VBoxOuter/MarginChoices/Grid/ButtonAnswer6
@onready var btn_answer_7: Button = $MarginOuter/VBoxOuter/MarginChoices/Grid/ButtonAnswer7
@onready var btn_answer_8: Button = $MarginOuter/VBoxOuter/MarginChoices/Grid/ButtonAnswer8


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(OS.get_data_dir())
	lesson = ChooseFromNineLesson.new()
	lesson.lesson_name = "Numbers"
	lesson.load_raw_data()
	lesson.prepare_all_steps()
	print(str(lesson.steps))
	draw_step(lesson.current_step_number)


func draw_step(step_num: int):
	if step_num >= lesson.number_of_steps:
		print("Lesson finished")
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
	lbl_remaining.text = str(lesson.number_of_remaining_steps())
	lbl_correct.text = str(lesson.number_of_correct_answers())
	lbl_wrong.text = str(lesson.number_of_wrong_answers())


func process_step(step_num: int, option_chosen: String):
	if step_num >= lesson.number_of_steps:
		print("Lesson finished")
		return

	var step = lesson.steps[step_num]
	step["chosen"] = option_chosen
	lesson.current_step_number += 1


func _on_button_answer_0_pressed() -> void:
	process_step(lesson.current_step_number, btn_answer_0.text)
	draw_step(lesson.current_step_number)


func _on_button_answer_1_pressed() -> void:
	process_step(lesson.current_step_number, btn_answer_1.text)
	draw_step(lesson.current_step_number)


func _on_button_answer_2_pressed() -> void:
	process_step(lesson.current_step_number, btn_answer_2.text)
	draw_step(lesson.current_step_number)


func _on_button_answer_3_pressed() -> void:
	process_step(lesson.current_step_number, btn_answer_3.text)
	draw_step(lesson.current_step_number)


func _on_button_answer_4_pressed() -> void:
	process_step(lesson.current_step_number, btn_answer_4.text)
	draw_step(lesson.current_step_number)


func _on_button_answer_5_pressed() -> void:
	process_step(lesson.current_step_number, btn_answer_5.text)
	draw_step(lesson.current_step_number)


func _on_button_answer_6_pressed() -> void:
	process_step(lesson.current_step_number, btn_answer_6.text)
	draw_step(lesson.current_step_number)


func _on_button_answer_7_pressed() -> void:
	process_step(lesson.current_step_number, btn_answer_7.text)
	draw_step(lesson.current_step_number)


func _on_button_answer_8_pressed() -> void:
	process_step(lesson.current_step_number, btn_answer_8.text)
	draw_step(lesson.current_step_number)
