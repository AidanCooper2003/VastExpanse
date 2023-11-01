extends Node
class_name UIManager

@export var _UI: UI
@export var _jobManager: JobManager
@export var _resourceManager: ResourceManager
@export var _purchaseableManager : PurchaseableManager
@export var _turnManager : TurnManager

func _ready():
	do_updates()
	

func do_updates():
	update_resource_labels()
	update_jobs()
	update_conversion_label()
	update_purchaseable_labels()

func update_jobs():
	for j in _jobManager.getAllJobNames():
		var description:= ""
		for r in _jobManager.getJobResources(j):
			description = description  + ("+ " + str(r.resourceAmount)
			 + " " + Enumerations.ResourceType.keys()[r.resourceType])
		_UI.update_job(j, _jobManager.getHireAmount(j), _jobManager.getMaxWorkers(j), description)
	# Resource labels will always be updated when jobs are updated


func update_resource_labels():
	for r in Enumerations.ResourceType:
		if Enumerations.ResourceType.get(r) != Enumerations.ResourceType.Population:
			_UI.update_resources(r, _resourceManager.get_current_resource(Enumerations.ResourceType.get(r)),
		 	_resourceManager.get_income(Enumerations.ResourceType.get(r)))
		# Temporary fix for population
		else:
			_UI.update_resources(r, _resourceManager.get_current_resource(Enumerations.ResourceType.get(r)),
		 	_jobManager.get_total_population_hired())


func update_conversion_label():
	_UI.update_conversion_label(_resourceManager.check_population_cost(0), _resourceManager.check_population_growth())
	
func update_purchaseable_labels():
	for p in _purchaseableManager.get_all_purchaseables():
		var priceString = _purchaseableManager.get_cost_resource(p._purchaseableName)
		_UI.update_purchasable(p._purchaseableName, p.get_cost(), p._rank, p.get_description(), priceString)

func hire_job(jobName: String, count: int):
	_jobManager.hire(jobName, count)
	do_updates()

func fire_job(jobName: String, count: int):
	_jobManager.hire(jobName, -count)
	do_updates()
	
func end_turn():
	_resourceManager.end_turn()
	_UI.update_turn_label(_turnManager.get_turn_count())
	update_resource_labels()
	
func make_purchase(purchaseableName: String):
	_purchaseableManager.attempt_purchase(purchaseableName)
	
func increment_turn():
	_turnManager.increment_turn()
