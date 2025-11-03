extends Node2D

@onready var grid_steps: GridContainer = $MarginContainer/VBoxContainer/MarginContainer/GridSteps
@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/GridSteps/TextureRect
@onready var lbl_progress: Label = $HBoxContainer/NinePatchRectProgress/LabelProgress
@onready var lbl_correct: Label = $HBoxContainer/NinePatchRectCorrect/LabelCorrect
@onready var lbl_wrong: Label = $HBoxContainer/NinePatchRectWrong/LabelWrong

var steps: Array[Step1in9]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	steps = Global.current_results
	draw_blocks()


func draw_blocks():
	var correct := 0
	var wrong := 0
	for s in steps:
		var step_block := TextureRect.new()
		step_block.custom_minimum_size.x = 32
		step_block.custom_minimum_size.y = 32
		# Why is this not working? all textures are the same when not loading separately
		#var texture_unanswered := load("res://assets/texture/panel-52x52-sand.png")
		#var texture_correct := load("res://assets/texture/panel-52x52-green.png")
		#var texture_wrong := load("res://assets/texture/panel-52x52-stone.png")
		var tooltip = "Question: " + s.question + "\n"
		match s.check_choice():
			StepStatus.CORRECT:
				step_block.texture = load("res://assets/texture/panel-52x52-green.png")
				tooltip = tooltip + "Answer: " + s.chosen + "\nis correct"
				correct += 1
			StepStatus.WRONG:
				step_block.texture = load("res://assets/texture/panel-52x52-stone.png")
				tooltip = tooltip + "Answer: " + s.chosen + "\nis wrong, correct answers:\n" + str(s.correct_answers)
				wrong += 1
			_:
				step_block.texture = load("res://assets/texture/panel-52x52-sand.png")
				tooltip = tooltip + "Unanswered, correct answers:\n" + str(s.correct_answers)
		step_block.tooltip_text = tooltip
		grid_steps.add_child(step_block)
	lbl_progress.text = "Steps\n" + str(steps.size())
	lbl_correct.text = "Correct\n" + str(correct)
	lbl_wrong.text = "Wrong\n" + str(wrong)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_exit_pressed() -> void:
	Global.goto_scene("res://scene/main_menu_scene.tscn")
