extends Control

@export var jobIcon: Texture2D
@export var increaseButton: Button
@export var decreaseButton: Button
@export var jobIconRect: TextureRect
@export var jobCountLabel: RichTextLabel
@export var jobDescriptionLabel: RichTextLabel
@export var jobTitle: String

func _ready():
	jobIconRect.texture = jobIcon
	_update_job_description("placeholder")
	_update_job_count(0, 10)

func _update_job_description(description: String):
	jobDescriptionLabel.text = jobTitle + ": " + description
	
func _update_job_count(currentWorkers: int, maxWorkers: int):
	jobCountLabel.text = str(currentWorkers) + " / " + str(maxWorkers)
