extends CanvasLayer
class_name UI

var _jobs = {}
var _purchasables = {}
var _resources = {}

@export var _uiManager: UIManager

@export var jobsContainer: Node
@export var technologyContainer: Node
@export var buildingsContainer: Node
@export var resourcesContainer: Node


# At some point, make jobs, purchasables, and resources interfaces so this
# doesn't use repeated code.
func _ready():
	for j in jobsContainer.get_children():
		_jobs[j.get_job_title()] = j
	for t in technologyContainer.get_children():
		_purchasables[t.get_purchasable_name()] = t
	for b in buildingsContainer.get_children():
		_purchasables[b.get_purchasable_name()] = b
	for r in resourcesContainer.get_children():
		_resources[r.get_resource_name] = r

func update_job(jobName: String, hired: int, max: int, description: String):
	_jobs[jobName].update_job_count(hired, max)
	_jobs[jobName].update_job_description(description)
	
func update_purchasable(purchasableName: String, cost: int, count: int):
	_purchasables[purchasableName].update_rank_label(count)
	_purchasables[purchasableName].update_cost_label(cost)

func update_resources(resourceName: String, current: int, income: int):
	_resources[resourceName].update_text(str(current) + " / +" + str(income))
	
func job_hire(jobName: String, count: int):
	_uiManager.hire_job(jobName, count)

func job_fire(jobName: String, count: int):
	_uiManager.fire_job(jobName, count)
