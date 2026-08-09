class_name Borehole
extends Node2D

@export var layer_colors: Array[Color] = []
@export var layer_heights: Array[int] = []
@export var speed_px: float = 5.0
@export var additive_speed: float = 5.0
@export var hole_width_px: int = 64
@export var bottom_offset: int = 32

@export var _background_sprite: Sprite2D
@onready var _background_image: Image
@onready var _background_texture: ImageTexture

const WIDTH = 256
const HEIGHT = 144

var depth_px: float = 0.0

func _ready() -> void:
	assert(len(layer_colors) > 0)
	assert(len(layer_colors) == len(layer_heights))
	
	_background_image = Image.create(WIDTH, HEIGHT, false, Image.FORMAT_RGBA8)
	_background_texture = ImageTexture.create_from_image(_background_image)
	_background_sprite.texture = _background_texture
	
	_draw_to_background()


func _physics_process(delta: float) -> void:
	depth_px += speed_px * delta


func _process(delta: float) -> void:
	_draw_to_background()


func _draw_to_background() -> void:
	for y in HEIGHT:
		var color = layer_colors[1]
		for layer_idx in len(layer_heights):
			if depth_px - HEIGHT + y <= layer_heights[layer_idx]:
				color = layer_colors[layer_idx]
				break
		
		var dark_color = Color(color)
		dark_color.v *= 0.6
		
		for x in WIDTH:
			if y < HEIGHT - bottom_offset and !(x < WIDTH / 2 - hole_width_px / 2 or x > WIDTH / 2 + hole_width_px / 2):
				_background_image.set_pixel(x, y, dark_color)
			else:
				_background_image.set_pixel(x, y, color)
	
	_background_texture.update(_background_image)
