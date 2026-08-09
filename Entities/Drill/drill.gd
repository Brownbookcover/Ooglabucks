extends Node2D

@export var _animation_player: AnimationPlayer


func _ready() -> void:
	_animation_player.play("vibrate")
