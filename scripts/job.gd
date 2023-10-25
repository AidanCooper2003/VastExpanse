class_name Job

var _jobName: String
var _jobHired: int
var _jobMax: int

# Returns number of workers set to be hired but couldn't be due to insufficient space or set to be fired 
# but couldn't due to insufficient workers to fire.
# If all workers could be hired, then the overflow is 0.
func hire(count: int):
	if _jobHired + count <= _jobMax and _jobHired + count > 0:
		_jobHired += count
		return 0
	else:
		var overflow = _jobMax - _jobHired + count
		_jobHired = _jobHired - overflow
		return overflow
		
		
func set_job_max(count: int):
	_jobMax = count

func set_job_name(jobName: String):
	_jobName = jobName
