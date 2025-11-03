# A class describing a lesson in "choose 1 in 9"

class_name Lesson extends Node


var lesson_name: String
var script_name: String


func _to_string():
	return "Lesson{ name:" + lesson_name + "}"
