extends Control

@export var _jobIcon: Texture2D
@export var _increaseButton: Button
@export var _decreaseButton: Button
@export var _jobIconRect: TextureRect
@export var _jobCountLabel: RichTextLabel
@export var _jobDescriptionLabel: RichTextLabel
@export var _jobTitle: String

func _ready():
	_jobIconRect.texture = _jobIcon
	_update_job_description("placeholder")
	_update_job_count(0, 10)

func _update_job_description(description: String):
	_jobDescriptionLabel.text = _jobTitle + ": " + description
	
func _update_job_count(currentWorkers: int, maxWorkers: int):
	_jobCountLabel.text = str(currentWorkers) + " / " + str(maxWorkers)
