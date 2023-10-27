extends Node
class_name UIManager

@export var _UI: UI
@export var _jobManager: JobManager
@export var _resourceManager: ResourceManager

func update_jobs():
	for j in _jobManager.getAllJobNames():
		var description:= ""
		for r in _jobManager.getJobResources(j):
			description = description  + ("+ " + str(r.resourceAmount) + " " + Enumerations.ResourceType.keys()[r.resourceType])
		_UI.update_job(j, _jobManager.getHireAmount(j), _jobManager.getMaxWorkers(j), description)
	# Resource labels will always be updated when jobs are updated
	update_resource_labels()
		
func update_purchasables():
	pass

func update_resource_labels():
	for r in Enumerations.ResourceType:
		_UI.update_resources(r, _resourceManager.get_current_resource(Enumerations.ResourceType.get(r)), _resourceManager.get_income(Enumerations.ResourceType.get(r)))

func hire_job(jobName: String, count: int):
	_jobManager.hire(jobName, count)
	update_jobs()

func fire_job(jobName: String, count: int):
	_jobManager.hire(jobName, -count)
	update_jobs()
	
func end_turn():
	_resourceManager.end_turn()
	update_resource_labels()
