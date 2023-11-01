extends Node
class_name ResourceManager

var resources = {}

@export var jobManager : JobManager
@export var _uiManager : UIManager
@export var _popCostMultiplier : int
@export var _popCostBase : int
@export var _initialPops : int
@export var _maxGrowthPerTurn: int


# Still need to add functionality for buildings/technologies to give flat resources!


func _ready():
	_create_resource(Enumerations.ResourceType.Energy)
	_create_resource(Enumerations.ResourceType.Materials)
	_create_resource(Enumerations.ResourceType.Knowledge)
	_create_resource(Enumerations.ResourceType.Population)
	set_current_resource(Enumerations.ResourceType.Population, _initialPops)

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
	grow_population()
	for r in Enumerations.ResourceType:
		if r != Enumerations.ResourceType.find_key(Enumerations.ResourceType.Population):
			gain_income(Enumerations.ResourceType.get(r))
	
# Set population offset to 0 for current cost.
func check_population_cost(populationOffset: int):
	return ((resources[Enumerations.ResourceType.Population].resourceAmount + populationOffset)
	 * _popCostMultiplier) + _popCostBase

func check_population_growth():
	var energy = check_future_resources(Enumerations.ResourceType.Energy)
	for i in _maxGrowthPerTurn:
		var cost = check_population_cost(i)
		if energy - cost < 0:
			return i
		else:
			energy -= cost
	return _maxGrowthPerTurn

func check_total_growth_cost(popCount: int):
	var cost := 0
	for i in popCount:
		cost += check_population_cost(i)
	return cost

func grow_population():
	var newPopCount = check_population_growth()
	var newEnergyAmount = get_current_resource(Enumerations.ResourceType.Energy) - check_total_growth_cost(newPopCount)
	set_current_resource(Enumerations.ResourceType.Population, newPopCount + 
		get_current_resource(Enumerations.ResourceType.Population))
	set_current_resource(Enumerations.ResourceType.Energy, newEnergyAmount)

