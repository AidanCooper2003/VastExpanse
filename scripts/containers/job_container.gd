extends Control

@export var _ui : UI

@export var _jobIcon: Texture2D
@export var _increaseButton: Button
@export var _decreaseButton: Button
@export var _jobIconRect: TextureRect
@export var _jobCountLabel: RichTextLabel
@export var _jobDescriptionLabel: RichTextLabel
@export var _jobTitle: String

func _ready():
	_jobIconRect.texture = _jobIcon
	update_job_description("placeholder")
	update_job_count(0, 10)

func update_job_description(description: String):
	_jobDescriptionLabel.text = _jobTitle + ": " + description
	
func update_job_count(currentWorkers: int, maxWorkers: int):
	_jobCountLabel.text = str(currentWorkers) + " / " + str(maxWorkers)

func get_job_title():
	return _jobTitle

func increase_pressed():
	_ui.job_hire(_jobTitle, 1)
	
func decrease_pressed():
	_ui.job_fire(_jobTitle, 1)
