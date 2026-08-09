extends Node2D


@onready var _drill_camera: Camera2D
@onready var _borehole_camera: Camera2D

func _ready():
	var cameras = find_children("*", "Camera2D") as Array[Camera2D]
	assert(len(cameras) == 2)
	
	if cameras[0].enabled:
		_drill_camera = cameras[0]
		_borehole_camera = cameras[1]
	else:
		_drill_camera = cameras[0]
		_borehole_camera = cameras[1]
	
	_drill_camera.enabled = true
	_borehole_camera.enabled = true
	_drill_camera.make_current()


func _on_camera_button_pressed() -> void:
	if _drill_camera.is_current():
		_borehole_camera.make_current()
	else:
		_drill_camera.make_current()
