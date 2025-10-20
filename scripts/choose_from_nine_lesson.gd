# A class describing a lesson in "choose 1 in 9"

class_name ChooseFromNineLesson extends Node


var lesson_name: String
var raw_data: Dictionary
var all_answers: Array[String]
var steps: Array
var current_step_number := 0
var number_of_steps := 10


func load_raw_data():
	var load_file = FileAccess.open("res://assets/choose_from_nine_raw_data.json", FileAccess.READ)
	print("loading: " + load_file.get_path_absolute())
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

# TODO prevent duplicated questions
func prepare_all_steps():
	for step_num in number_of_steps:
		prepare_single_step(step_num)

func prepare_single_step(step_num: int):
	var raw_data_entry_number := randi_range(0, raw_data.size() - 1)
	var question: String = raw_data.keys()[raw_data_entry_number]
	var correct_answers = raw_data[question]
	print("raw_data_entry-> " + question + ": " + str(correct_answers))
	steps.append({
		"question": question,
		"correct_answers": correct_answers,
		"choices": prepare_choices(correct_answers),
		"chosen": ""
	})
	
# Prepare an array of 9 options, including at least one correct
# TODO prevent duplicated answers
func prepare_choices(correct: Array) -> Array:
	var additional: Array[String]
	for i in 9 - correct.size():
		var random_answer_from_all := all_answers[randi_range(0, all_answers.size() - 1)]
		additional.append(random_answer_from_all)
	var nine_options := correct.duplicate()
	nine_options.append_array(additional)
	return nine_options


func number_of_remaining_steps() -> int:
	return steps.size() - current_step_number


func number_of_correct_answers() -> int:
	var found_correct := 0
	for a_step in steps:
		if a_step["chosen"] != "":
			if a_step["correct_answers"].has(a_step["chosen"]):
				found_correct += 1
	return found_correct


func number_of_wrong_answers() -> int:
	var found_wrong := 0
	for a_step in steps:
		if a_step["chosen"] != "":
			if not a_step["correct_answers"].has(a_step["chosen"]):
				found_wrong += 1
	return found_wrong
