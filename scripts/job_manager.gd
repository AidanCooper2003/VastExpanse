extends Node



var jobs = {}


func _ready():
	_create_job("Technician", 10)
	_create_job("Extractor", 10)
	_create_job("Researcher", 10)

func _create_job(jobName: String, jobMax: int):
	var job = Job.new()
	job.set_job_max(jobMax)
	job.set_job_name(jobName)
	jobs[jobName] = job
	

func hire(jobName: String, count: int):
	var overflow = jobs[jobName].hire(count)
	print(overflow)
