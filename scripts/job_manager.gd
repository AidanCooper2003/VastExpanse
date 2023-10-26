extends Node
class_name JobManager



var jobs = {}


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
	jobs[jobName].hire(count)

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

func getResourceFromJobs(resourceType: Enumerations.ResourceType):
	var total := 0
	for j in jobs.keys():
		for r in getJobResources(j.jobName):
			if r.resourceType == resourceType:
				total += r.getJobResources()
	return total

func getAllJobNames():
	return jobs.keys()
