class_name Laser
extends Node2D

@export_range(0, 7) var color: int = 0:
	set = _set_color
@export_range(0, 5) var size: int = 0:
	set = _set_size

@onready var _sprite: Sprite2D = %Sprite2D


func _set_color(value: int) -> void:
	if value < 0 or value > 7:
		return
	
	color = value
	_sprite.region_rect.position.y = 16 * color


func _set_size(value: int) -> void:
	if value < 0 or value > 5:
		return
	
	size = value
	_sprite.region_rect.position.x = 32 * size
