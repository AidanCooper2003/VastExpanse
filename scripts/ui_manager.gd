extends Node
class_name UIManager

@export var _UI: UI
@export var _jobManager: JobManager

func update_jobs():
	for j in _jobManager.getAllJobNames():
		var description:= ""
		for r in _jobManager.getJobResources(j):
			description = description  + ("+ " + str(r.resourceAmount) + " " + Enumerations.ResourceType.keys()[r.resourceType])
		_UI.update_job(j, _jobManager.getHireAmount(j), _jobManager.getMaxWorkers(j), description)

func hire_job(jobName: String, count: int):
	_jobManager.hire(jobName, count)
	update_jobs()
	
func fire_job(jobName: String, count: int):
	_jobManager.hire(jobName, -count)
	update_jobs()
