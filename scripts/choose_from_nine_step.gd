# A class describing a step in a lesson type "choose 1 in 9"

class_name ChooseFromNineStep extends Node

var question: String
# Array of all possible correct answers
var correct_answers: Array[String]
# Array of choices made of correct and random wrong options
var choices: Array[String]
# Chosen answer, empty if not selected yet
var chosen: String = ""


func _init(a_question: String, a_corrects: Array[String], all_options: Array[String]):
	self.question = a_question
	self.correct_answers = a_corrects
	self.choices = prepare_choices(9, a_corrects, all_options)


func _to_string():
	return "Step{ qn:" + question + ", chosen:" + chosen + ", " + ", crct:" + str(correct_answers) + ", choices:" + str(choices) + "}"


# Prepare an array of number of options, including at least one correct
func prepare_choices(num_of_choices: int, a_corrects: Array[String], all_options: Array[String]) -> Array[String]:
	var additional: Array[String]
	var wrong_to_be_added = num_of_choices - a_corrects.size()
	print("Prepare " + str(num_of_choices) + " choices: " + str(a_corrects.size()) + " correct, " + str(wrong_to_be_added) + " wrong")
	var i = 0
	while i < wrong_to_be_added:
		var random_answer_from_all := all_options[randi_range(0, all_options.size() - 1)]
		if !additional.has(random_answer_from_all):
			additional.append(random_answer_from_all)
			i += 1
	var nine_options := a_corrects.duplicate()
	nine_options.append_array(additional)
	nine_options.shuffle()
	return nine_options


func check_choice() -> int:
	if chosen == "":
		return StepStatus.UNANSWERED
	elif correct_answers.has(chosen):
		return StepStatus.CORRECT
	else:
		return StepStatus.WRONG
