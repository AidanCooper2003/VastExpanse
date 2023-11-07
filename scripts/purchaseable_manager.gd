extends Node
class_name PurchaseableManager

@export var _jobManager : JobManager
@export var _resourceManager : ResourceManager

var purchaseables = {}

var defaultBuildingBaseCost := 10
var defaultTechnologyBaseCost := 10
var defaultBuildingScalingCost := 7
var defaultTechnologyScalingCost := 10
var defaultMaxRank := 1000
var defaultBuildingDescriptionScale := 5
var defaultTechnologyDescriptionScale := 1

func _ready():
	_make_default_building("Maximum Extractors", "Mantle Mining Camp", Enumerations.ResourceType.Materials, "Extractor")
	_make_default_building("Maximum Technicians", "Battery Manufactorium", Enumerations.ResourceType.Energy, "Technician")
	_make_default_building("Maximum Researchers", "Campus", Enumerations.ResourceType.Knowledge, "Researcher")
	_make_default_technology("Knowledge from Researchers", "Computational Efficiency", Enumerations.ResourceType.Knowledge, "Researcher")
	_make_default_technology("Material from Extractors", "Heat Shields", Enumerations.ResourceType.Materials, "Extractor")
	_make_default_technology("Energy from Technicians", "Solar Cells", Enumerations.ResourceType.Energy, "Technician")

func _make_default_technology(description: String, purchaseableName: String, affectedResource: Enumerations.ResourceType, affectedJob: String):
	_make_purchaseable(defaultTechnologyScalingCost, defaultTechnologyBaseCost, defaultMaxRank, defaultTechnologyDescriptionScale,
	description, purchaseableName, affectedJob, affectedResource, Enumerations.UpgradeType.ResourceBonus, Enumerations.PurchaseType.Technology)

func _make_default_building(description: String, purchaseableName: String, affectedResource: Enumerations.ResourceType, affectedJob: String):
	_make_purchaseable(defaultBuildingScalingCost, defaultBuildingBaseCost, defaultMaxRank, defaultBuildingDescriptionScale,
	description, purchaseableName, affectedJob, affectedResource, Enumerations.UpgradeType.MaxWorkerBonus, Enumerations.PurchaseType.Building)

func _make_purchaseable(scalingCost: int, baseCost: int, maxRank: int, descriptionUpgradeScale: int,
description: String, purchaseableName: String, jobAffected: String, 
affectedResource: Enumerations.ResourceType,
upgradeType: Enumerations.UpgradeType,
purchaseableClass: Enumerations.PurchaseType):
	var purchaseable = Purchaseable.new()
	purchaseable._scalingCost = scalingCost
	purchaseable._baseCost = baseCost
	purchaseable._maxRank = maxRank
	purchaseable._descriptionUpgradeScale = descriptionUpgradeScale
	purchaseable._description = description
	purchaseable._purchaseableName = purchaseableName
	purchaseable._affectedResource = affectedResource
	purchaseable._upgradeType = upgradeType
	purchaseable._type = purchaseableClass
	purchaseables[purchaseableName] = purchaseable
	purchaseable._jobAffected = jobAffected
	
func get_purchaseable_description(purchaseable: String):
	purchaseables[purchaseable].get_description()
	
func get_all_purchaseables():
	return purchaseables.values()
	
func attempt_purchase(purchaseableName: String):
	var purchaseable = purchaseables[purchaseableName]
	var resourceType = get_cost_resource(purchaseableName)
	var totalResources = _resourceManager.get_current_resource(Enumerations.ResourceType[resourceType])
	var cost = purchaseable.get_cost() 
	if cost <= totalResources:
		_resourceManager.set_current_resource(Enumerations.ResourceType[resourceType], totalResources - cost)
		activate_purchaseable_effect(purchaseableName)
	
func get_cost_resource(purchaseableName):
	var purchaseable = purchaseables[purchaseableName]
	if purchaseable._type == Enumerations.PurchaseType.Building:
		return "Materials"
	elif purchaseable._type == Enumerations.PurchaseType.Technology:
		return "Knowledge"

func activate_purchaseable_effect(purchaseableName):
	var purchaseable = purchaseables[purchaseableName]
	var jobName = purchaseable._jobAffected
	var upgradeScale = purchaseable._descriptionUpgradeScale
	if purchaseable._upgradeType == Enumerations.UpgradeType.ResourceBonus:
		var resourceType = purchaseable._affectedResource
		var currentProduction = _jobManager.getPacketProductionFromJob(resourceType, jobName)
		_jobManager.modifyJob(jobName, purchaseable._affectedResource, upgradeScale + currentProduction)
	elif purchaseable._upgradeType == Enumerations.UpgradeType.MaxWorkerBonus:
		_jobManager.set_max_workers(jobName, _jobManager.getMaxWorkers(jobName) + upgradeScale)
	purchaseable._rank += 1

func get_total_ranks(purchaseType : Enumerations.PurchaseType):
	var rank = 0
	for p in get_all_purchaseables():
		if p._type == purchaseType:
			rank += p._rank
	return rank
