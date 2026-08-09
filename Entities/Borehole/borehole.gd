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

var rng = RandomNumberGenerator.new()
var DeltaCounter = 0

const WIDTH = 256
const HEIGHT = 144

var depth_px: float = 0.0

var RockArray: Array[Node2D] = []

@export var laser: Laser
@export var RockScene: PackedScene

func _ready() -> void:
	assert(len(layer_colors) > 0)
	assert(len(layer_colors) == len(layer_heights))
	
	_background_image = Image.create(WIDTH, HEIGHT, false, Image.FORMAT_RGBA8)
	_background_texture = ImageTexture.create_from_image(_background_image)
	_background_sprite.texture = _background_texture
	
	_draw_to_background()


func _physics_process(delta: float) -> void:
	depth_px += speed_px * delta
	DeltaCounter += delta
	if DeltaCounter >= 1:
		var my_random_number = rng.randi_range(0, 10)
		if my_random_number == 6:
			DeltaCounter = 0
			var rock = RockScene.instantiate()
			add_child(rock)
			RockArray.append(rock)
			my_random_number = rng.randi_range(4, 252)
			while my_random_number > 89 and my_random_number < 167:
				my_random_number = rng.randi_range(4, 252)
			rock.position.x += my_random_number
			rock.position.y += 150
	for rock in RockArray:
		rock.position.y -= speed_px * delta
		if rock.position.y <= -20:
			RockArray.erase(rock)
			rock.queue_free()


func _process(delta: float) -> void:
	_draw_to_background()


func _draw_to_background() -> void:
	for y in HEIGHT:
		var color = layer_colors[1]
		var total_height = 0
		for layer_idx in len(layer_heights):
			total_height += layer_heights[layer_idx]
			if depth_px - (HEIGHT - y) <= total_height:
				color = layer_colors[layer_idx]
				break
		
		var dark_color = Color(color)
		dark_color.v *= 0.6
		
		for x in WIDTH:
			if y < HEIGHT - bottom_offset and !(x < WIDTH / 2.0 - hole_width_px / 2.0 or x > WIDTH / 2.0 + hole_width_px / 2.0):
				_background_image.set_pixel(x, y, dark_color)
			else:
				_background_image.set_pixel(x, y, color)
	
	_background_texture.update(_background_image)
