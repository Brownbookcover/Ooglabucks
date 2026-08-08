@tool
class_name Laser
extends Node2D

@export_range(0, 7) var color: int = 0:
	set = _set_color
@export_range(0, 4) var width: int = 0:
	set = _set_width
@export_range(0, 100, 1, "or_greater") var height_px: int = 16:
	set = _set_height_px

@export var _sprite: Sprite2D


func _set_color(value: int) -> void:
	if value < 0 or value > 7:
		return
	
	color = value
	_sprite.region_rect.position.y = 16 * color


func _set_width(value: int) -> void:
	if value < 0 or value > 4:
		return
	
	width = value
	_sprite.region_rect.position.x = 32 * width


func _set_height_px(value: int) -> void:
	if value < 0:
		return
	
	height_px = value
	_sprite.scale.y = height_px / 16.0
