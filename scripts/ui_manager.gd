extends Node
class_name UIManager

@export var _UI: UI
@export var _jobManager: JobManager
@export var _resourceManager: ResourceManager

func _ready():
	update_jobs()
	

func update_jobs():
	for j in _jobManager.getAllJobNames():
		var description:= ""
		for r in _jobManager.getJobResources(j):
			description = description  + ("+ " + str(r.resourceAmount)
			 + " " + Enumerations.ResourceType.keys()[r.resourceType])
		_UI.update_job(j, _jobManager.getHireAmount(j), _jobManager.getMaxWorkers(j), description)
	# Resource labels will always be updated when jobs are updated
	update_resource_labels()
		
func update_purchasables():
	pass


func update_resource_labels():
	for r in Enumerations.ResourceType:
		if Enumerations.ResourceType.get(r) != Enumerations.ResourceType.Population:
			_UI.update_resources(r, _resourceManager.get_current_resource(Enumerations.ResourceType.get(r)),
		 	_resourceManager.get_income(Enumerations.ResourceType.get(r)))
		# Temporary fix for population
		else:
			_UI.update_resources(r, _resourceManager.get_current_resource(Enumerations.ResourceType.get(r)),
		 	_jobManager.get_total_population_hired())
	update_conversion_label()

func update_conversion_label():
	_UI.update_conversion_label(_resourceManager.check_population_cost(0), _resourceManager.check_population_growth())

func hire_job(jobName: String, count: int):
	_jobManager.hire(jobName, count)
	update_jobs()

func fire_job(jobName: String, count: int):
	_jobManager.hire(jobName, -count)
	update_jobs()
	
func end_turn():
	_resourceManager.end_turn()
	update_resource_labels()
