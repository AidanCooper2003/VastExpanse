extends Node
class_name TurnManager

@export var purchasableManager : PurchaseableManager
@export var resourceManager: ResourceManager
@export var uiManager : UIManager

@export var techWeight : int
@export var popWeight : int
@export var buildingWeight : int

@export var finalTurn : int

var turnNumber:= 1

func increment_turn():
	turnNumber += 1
	if turnNumber == finalTurn + 1:
		end_game()

func get_turn_count():
	return turnNumber

func get_tech_score():
	return purchasableManager.get_total_ranks(Enumerations.PurchaseType.Technology) * techWeight

func get_population_score():
	return resourceManager.get_current_resource(Enumerations.ResourceType.Population) * popWeight

func get_building_score():
	return purchasableManager.get_total_ranks(Enumerations.PurchaseType.Building) * buildingWeight

func get_total_score():
	return get_tech_score() + get_population_score() + get_building_score()
	
func end_game():
	uiManager.update_end_score(get_tech_score(), get_population_score(), get_building_score(), get_total_score())
