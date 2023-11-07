extends Node
class_name Purchaseable

var _rank: int
var _baseCost: int
var _scalingCost: int
var _descriptionUpgradeScale: int
var _description : String
var _purchaseableName: String
var _affectedResource : Enumerations.ResourceType
var _jobAffected : String
var _upgradeType : Enumerations.UpgradeType
var _maxRank: int
var _type: Enumerations.PurchaseType

func get_description():
	return "+" + str((_rank) * _descriptionUpgradeScale) + " | " + str(_descriptionUpgradeScale) + " " + _description

func get_rank():
	return _rank

func get_cost():
	return ceil(pow(_baseCost + (_scalingCost * _rank), (1 + _rank * 0.02)))
