extends Control

@export var _gradient_texture: GradientTexture1D
@export var _laser_rect: ColorRect
@export var _depth_label: Label
@export var _borehole: Borehole

@onready var meter_height = %Gradient.size.x

@onready var start_padding
@onready var total_height

func _ready() -> void:
	assert(len(_borehole.layer_colors) == len(_gradient_texture.gradient.colors))
	assert(len(_borehole.layer_heights) == len(_gradient_texture.gradient.offsets))
	
	for i in len(_borehole.layer_colors):
		_gradient_texture.gradient.colors[i] = _borehole.layer_colors[i]
	
	start_padding = _borehole.HEIGHT - _borehole.bottom_offset
	total_height = _borehole.layer_heights.reduce(func(a, n): return a + n)# + start_padding
	var depth = 0
	for i in len(_borehole.layer_heights):
		_gradient_texture.gradient.set_offset(i, float(depth) / total_height)
		depth += _borehole.layer_heights[i]
		
		if i == 0:
			depth += start_padding
	
	_gradient_texture.gradient = _gradient_texture.gradient


func _process(_delta: float) -> void:
	_laser_rect.size.y = ((start_padding + _borehole.depth_px - _borehole.bottom_offset) / total_height) * meter_height
	
	_depth_label.text = str(int(start_padding + _borehole.depth_px)) + "m"
