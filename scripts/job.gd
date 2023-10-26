class_name Job

var _jobName: String
var _jobHired: int
var _jobMax: int

# Every resource pack is added together to create the end of turn income for each worker.
# You can only have packet for each resource type.
var _resourcePackets := []

# Returns number of workers set to be hired but couldn't be due to insufficient space or set to be fired 
# but couldn't due to insufficient workers to fire.
# If all workers could be hired, then the overflow is 0.
func hire(count: int):
	if _jobHired + count <= _jobMax and _jobHired + count > 0:
		_jobHired += count
		return 0
	else:
		var overflow = _jobMax - _jobHired + count
		_jobHired = clamp(_jobHired + count, 0, _jobMax)
		return overflow
		
		
func set_job_max(count: int):
	_jobMax = count

func set_job_name(jobName: String):
	_jobName = jobName
	
func get_job_count():
	return _jobHired
	
func get_job_name():
	return _jobName
	
func get_job_max():
	return _jobMax
	

# Check here if there are issues, returning null is probably not a good idea but there is no nullable in GDScript
func find_resource_packet(resourceType: Enumerations.ResourceType):
	for r in _resourcePackets:
		if r.resourceType == resourceType:
			return r
	return null

func add_resource_packet(resourceType: Enumerations.ResourceType, resourceAmount: int):
	var oldResourcePacket = find_resource_packet(resourceType)
	if oldResourcePacket == null:
		var resourcePacket = ResourcePacket.new()
		resourcePacket.resourceAmount = resourceAmount
		resourcePacket.resourceType = resourceType
		_resourcePackets.append(resourcePacket)
	else:
		oldResourcePacket.resourceAmount = resourceAmount
		
func get_resource_packets():
	return _resourcePackets
