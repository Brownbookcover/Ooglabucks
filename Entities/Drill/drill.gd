class_name Drill
extends Node2D

@export var _animation_player: AnimationPlayer
@export var _audio_stream_player: AudioStreamPlayer2D

@export var laser: Laser

func _ready() -> void:
	_animation_player.play("vibrate")


func _on_audio_stream_player_2d_finished() -> void:
	_audio_stream_player.play()
