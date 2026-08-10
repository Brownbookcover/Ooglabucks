extends ColorRect

@export var ui: UI
@export var drill: Drill
@export var borehole: Borehole
@export var label: RichTextLabel


func _on_borehole_layer_breached(layer: int) -> void:
	if layer != 5:
		return
	
	label.text = """You have breached all the [b]shells[/b] of the planet and reached the center!

You earned %s Ooglabucks!

Congratulations!
""" % UI.MoneyConversionFunction(ui.AllTimeMoney)
	
	ui.visible = false
	visible = true
	drill.process_mode = Node.PROCESS_MODE_DISABLED
	borehole.process_mode = Node.PROCESS_MODE_DISABLED
