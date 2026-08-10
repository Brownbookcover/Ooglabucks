class_name Borehole
extends Node2D

signal layer_breached(layer: int)

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
@export var _audio_stream_player: AudioStreamPlayer2D

const WIDTH = 256
const HEIGHT = 144

var depth_px: float = 0.0

var RockArray: Array[Node2D] = []

@export var laser: Laser
@export var RockScene: PackedScene

var last_depth_int: int = -1
var last_breached_layer: int = -1

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



func _process(delta: float) -> void:
	_draw_to_background()


func _draw_to_background() -> void:
	var current_depth_int: int = int(floor(depth_px))
	if last_depth_int != -1 and current_depth_int > last_depth_int:
		for rock in RockArray:
			rock.position.y -= 1
			if rock.position.y <= -20:
				RockArray.erase(rock)
				rock.queue_free()
	last_depth_int = current_depth_int
	
	var half_width: float = WIDTH / 2.0
	var half_hole_w: float = hole_width_px / 2.0
	var hole_left: float = half_width - half_hole_w
	var hole_right: float = half_width + half_hole_w
	var partial: float = fposmod(depth_px, 1.0)

	var active_layer_idx = 1
	var total_height = 0
	
	for layer_idx in len(layer_heights):
		total_height += layer_heights[layer_idx]

		if depth_px <= total_height + bottom_offset:
			active_layer_idx = layer_idx
			break

	if active_layer_idx != last_breached_layer:
		last_breached_layer = active_layer_idx
		layer_breached.emit(active_layer_idx)
	
	if depth_px >= 50000:
		layer_breached.emit(5)

	for y in HEIGHT:
		var color = layer_colors[1]
		total_height = 0
		
		for layer_idx in len(layer_heights):
			total_height += layer_heights[layer_idx]
			if depth_px - (HEIGHT - y) <= total_height:
				color = layer_colors[layer_idx]
				break
		
		var dark_color = Color(color)
		dark_color.v *= 0.6
		
		var is_below_offset: bool = (y <= HEIGHT - bottom_offset)
		var is_at_edge: bool = (y == HEIGHT - bottom_offset)
		
		for x in WIDTH:
			var in_hole: bool = (x >= hole_left and x <= hole_right)
			
			if is_below_offset and in_hole:
				if is_at_edge:
					var dist_from_center: float = absf(x - half_width)
					var center_fraction: float = dist_from_center / (hole_width_px / 2.0)
					
					if center_fraction > partial:
						_background_image.set_pixel(x, y, color)
					else:
						_background_image.set_pixel(x, y, dark_color)
				else:
					_background_image.set_pixel(x, y, dark_color)
			else:
				_background_image.set_pixel(x, y, color)
	
	_background_texture.update(_background_image)


func _on_audio_stream_player_2d_finished() -> void:
	_audio_stream_player.play()
