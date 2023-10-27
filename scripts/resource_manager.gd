extends Node
class_name ResourceManager

var resources = {}

@export var jobManager : JobManager
@export var _uiManager : UIManager


# Still need to add functionality for buildings/technologies to give flat resources!


func _ready():
	_create_resource(Enumerations.ResourceType.Energy)
	_create_resource(Enumerations.ResourceType.Materials)
	_create_resource(Enumerations.ResourceType.Knowledge)

func _create_resource(resourceType: Enumerations.ResourceType):
	var resourcePacket = ResourcePacket.new()
	resourcePacket.resourceType = resourceType
	resourcePacket.resourceAmount = 0
	resources[resourceType] = resourcePacket

func gain_income(resourceType: Enumerations.ResourceType):
	set_current_resource(resourceType, check_future_resources(resourceType))

func check_future_resources(resourceType: Enumerations.ResourceType):
	return jobManager.getResourceFromJobs(resourceType) + get_current_resource(resourceType)

func get_current_resource(resourceType: Enumerations.ResourceType):
	return resources[resourceType].resourceAmount

func set_current_resource(resourceType: Enumerations.ResourceType, resourceCount: int):
	resources[resourceType].resourceAmount = resourceCount

func get_income(resourceType: Enumerations.ResourceType):
	return jobManager.getResourceFromJobs(resourceType)

func end_turn():
	for r in Enumerations.ResourceType:
		gain_income(Enumerations.ResourceType.get(r))
	_uiManager.update_resource_labels()

