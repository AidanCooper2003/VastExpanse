extends Node

@export var _audioStreamPlayer : AudioStreamPlayer

func music_ended():
	_audioStreamPlayer.play()
