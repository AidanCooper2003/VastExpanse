extends Node
class_name PurchaseableManager

@export var _jobManager : JobManager

var purchaseables = {}

var defaultBuildingBaseCost := 10
var defaultTechnologyBaseCost := 10
var defaultBuildingScalingCost := 8
var defaultTechnologyScalingCost := 10
var defaultMaxRank := 1000
var defaultBuildingDescriptionScale := 10
var defaultTechnologyDescriptionScale := 1

func _ready():
	_make_default_building("Maximum Extractors", "Mantle Mining Camp", Enumerations.ResourceType.Materials)
	_make_default_building("Maximum Technicians", "Battery Manufactorium", Enumerations.ResourceType.Energy)
	_make_default_building("Maximum Researchers", "Campus", Enumerations.ResourceType.Knowledge)
	_make_default_technology("Knowledge from Researchers", "Computational Efficiency", Enumerations.ResourceType.Knowledge)
	_make_default_technology("Material from Extractors", "Heat Shields", Enumerations.ResourceType.Materials)
	_make_default_technology("Energy from Technicians", "Solar Cells", Enumerations.ResourceType.Energy)

func _make_default_technology(description: String, purchaseableName: String, affectedResource: Enumerations.ResourceType):
	_make_purchaseable(defaultTechnologyScalingCost, defaultTechnologyBaseCost, defaultMaxRank, defaultTechnologyDescriptionScale,
	description, purchaseableName, affectedResource, Enumerations.UpgradeType.ResourceBonus, Enumerations.PurchaseType.Technology)

func _make_default_building(description: String, purchaseableName: String, affectedResource: Enumerations.ResourceType):
	_make_purchaseable(defaultBuildingScalingCost, defaultBuildingBaseCost, defaultMaxRank, defaultBuildingDescriptionScale,
	description, purchaseableName, affectedResource, Enumerations.UpgradeType.MaxWorkerBonus, Enumerations.PurchaseType.Building)

func _make_purchaseable(scalingCost: int, baseCost: int, maxRank: int, descriptionUpgradeScale: int,
description: String, purchaseableName: String, 
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
	
func get_purchaseable_description(purchaseable: String):
	purchaseables[purchaseable].get_description()
	
func get_all_purchaseables():
	return purchaseables.values()
	

