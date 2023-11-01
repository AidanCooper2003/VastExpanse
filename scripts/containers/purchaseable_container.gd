extends Control

@export var _ui : UI

@export var _purchaseButton : Button
@export var _rankLabel : RichTextLabel
@export var _costLabel : RichTextLabel
@export var _descriptionLabel : RichTextLabel
@export var _nameLabel : RichTextLabel
@export var _icon : Texture2D
@export var _purchaseableName : String
@export var _effectDescription : String


# Currently unused
@export var purchaseType : Enumerations.PurchaseType


# Called when the node enters the scene tree for the first time.
func _ready():
	_update_cost_label("placeholder")
	_update_rank_label("0")
	_update_description_label(_effectDescription)
	_update_name_label(_purchaseableName)
	_update_icon(_icon)

func _update_rank_label(rank: String):
	_rankLabel.text = rank

func _update_cost_label(cost: String):
	_costLabel.text = cost

func _update_description_label(description: String):
	_descriptionLabel.text = description
	
func _update_name_label(purchaseableName: String):
	_nameLabel.text = purchaseableName
	
func _update_icon(iconImage: Texture2D):
	_purchaseButton.icon = iconImage
	
func get_purchasable_name():
	return _purchaseableName
	
func purchase_pressed():
	_ui.make_purchase(_purchaseableName)
