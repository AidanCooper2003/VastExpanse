extends RichTextLabel

@export var _resourceName: String

func update_text(description: String):
	self.text = description

func get_resource_name():
	return _resourceName
