# A class describing a lesson in "choose 1 in 9"

class_name ChooseFromNineLesson extends Node


var lesson_name: String
var number_of_choices: int
# Raw data of Dictionary[String,Array[String]], example:
# { "question": ["correct1", "correct2"] }
var raw_data: Dictionary
# An array of all answers for any question in raw data
var all_answers: Array[String]
# An Array of steps - they can be answered or not
var steps: Array[ChooseFromNineStep]
var current_step_number := 0


func _init(a_number_of_steps: int, a_lesson_name: String, a_data_file_name: String, a_number_of_choices: int = 9, only_first_x_data_rows: int = -1):
	self.lesson_name = a_lesson_name
	self.number_of_choices = a_number_of_choices
	load_raw_data(a_data_file_name)
	prepare_all_steps(a_number_of_steps, only_first_x_data_rows)


func _to_string():
	return "Lesson1of9{ name:" + lesson_name + ", prgs:" + str(current_step_number) + "/" + str(steps.size()) + ", raw_size:" + str(raw_data.size()) + ", all_answers:" + str(all_answers.size()) + "}"


func load_raw_data(a_data_file_name: String):
	var load_file = FileAccess.open("res://assets/data/" + a_data_file_name + ".json", FileAccess.READ)
	print("Loading raw data: " + load_file.get_path_absolute() + "; for lesson " + lesson_name)
	var json_text = load_file.get_as_text()
	var json = JSON.new()
	var error = json.parse(json_text)
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			print(data_received)
			raw_data = data_received
		else:
			print("Unexpected data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_text, " at line ", json.get_error_line())
	for key in raw_data:
			print(str(raw_data[key]))
			all_answers.append_array(raw_data[key])


func prepare_all_steps(a_number_of_steps: int, only_first_x_data_rows: int = -1):
	for step_num in a_number_of_steps:
		steps.append(prepare_single_step(step_num, only_first_x_data_rows))


func prepare_single_step(step_num: int, only_first_x_data_rows: int = -1) -> ChooseFromNineStep:
	var range_reduced := raw_data.size() -1
	if only_first_x_data_rows > -1:
		range_reduced = range_reduced % only_first_x_data_rows
	var raw_data_entry_number := randi_range(0,  range_reduced)
	var question: String = raw_data.keys()[raw_data_entry_number]
	var correct_answers: Array[String] 
	correct_answers.assign(raw_data[question])
	print("raw_data_entry " + question + ": " + str(correct_answers))
	var step := ChooseFromNineStep.new(question, correct_answers, all_answers)
	print("created step: " + str(step))
	return step
	
#
func number_of_remaining_steps() -> int:
	return steps.size() - current_step_number


func number_of_correct_and_wrong_answers() -> Dictionary[String, int]:
	var found_correct := 0
	var found_wrong := 0
	for a_step in steps:
		var corectness := a_step.check_choice()
		match corectness:
			1:
				found_correct += 1
			-1:
				found_wrong += 1
	return {
		"correct": found_correct,
		"wrong": found_wrong
		}
