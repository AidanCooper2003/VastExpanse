extends Node
class_name TurnManager


var turnNumber:= 1

func increment_turn():
	turnNumber += 1

func get_turn_count():
	return turnNumber
