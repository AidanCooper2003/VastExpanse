extends Node
class_name JobManager



var jobs = {}
var totalPopulationHired := 0
@export var _resourceManager : ResourceManager

func _ready():
	_create_job("Technician", 10)
	_create_job("Extractor", 10)
	_create_job("Researcher", 10)
	jobs["Technician"].add_resource_packet(Enumerations.ResourceType.Energy, 2)
	jobs["Extractor"].add_resource_packet(Enumerations.ResourceType.Materials, 2)
	jobs["Researcher"].add_resource_packet(Enumerations.ResourceType.Knowledge, 2)

func _create_job(jobName: String, jobMax: int):
	var job = Job.new()
	job.set_job_max(jobMax)
	job.set_job_name(jobName)
	jobs[jobName] = job

func hire(jobName: String, count: int):
	var currentPopulation = _resourceManager.get_current_resource(Enumerations.ResourceType.Population)
	if totalPopulationHired + count > currentPopulation:
		count = currentPopulation - totalPopulationHired
	var overflow = jobs[jobName].hire(count)
	totalPopulationHired = clamp(totalPopulationHired + count - overflow, 0, 
	_resourceManager.get_current_resource(Enumerations.ResourceType.Population))

func getHireAmount(jobName: String):
	return jobs[jobName].get_job_count()

func getMaxWorkers(jobName: String):
	return jobs[jobName].get_job_max()

func getJobResources(jobName: String):
	var resources = []
	var job = jobs[jobName]
	for r in job.get_resource_packets():
		var multipliedPacket = ResourcePacket.new()
		multipliedPacket.resourceType = r.resourceType
		multipliedPacket.resourceAmount = r.resourceAmount * job.get_job_count()
		resources.append(multipliedPacket)
	return resources

func getSpecificResourceFromJob(jobName: String, resource: Enumerations.ResourceType):
	for r in getJobResources(jobName):
		if r.resourceType == resource:
			return r.resourceAmount

func getResourceFromJobs(resourceType: Enumerations.ResourceType):
	var total := 0
	for j in jobs.keys():
		for r in getJobResources(j):
			if r.resourceType == resourceType:
				total += r.resourceAmount
	return total
	
func getPacketProductionFromJob(resourceType: Enumerations.ResourceType, jobName: String):
	return jobs[jobName].find_resource_packet(resourceType).resourceAmount

func getAllJobNames():
	return jobs.keys()
	
func modifyJob(jobName: String, resourceType: Enumerations.ResourceType, resourceAmount: int):
	var job = jobs[jobName]
	job.add_resource_packet(resourceType, resourceAmount)

func set_max_workers(jobName: String, newMax: int):
	jobs[jobName].set_job_max(newMax)
	
func get_total_population_hired():
	return totalPopulationHired
