class_name Drill
extends Node2D

@export var _animation_player: AnimationPlayer

@export var laser: Laser

func _ready() -> void:
	_animation_player.play("vibrate")
