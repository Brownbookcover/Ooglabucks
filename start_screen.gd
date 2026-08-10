extends ColorRect

@export var ui: Control
@export var drill: Drill
@export var borehole: Borehole

func _on_button_pressed() -> void:
	#ui.visible = true
	visible = false
	ui.process_mode = Node.PROCESS_MODE_INHERIT
	drill.process_mode = Node.PROCESS_MODE_INHERIT
	borehole.process_mode = Node.PROCESS_MODE_INHERIT
