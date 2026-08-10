extends ColorRect

@export var timer: Timer
@export var label: Label


func _on_timer_timeout() -> void:
	visible = false


static func _int_to_ordinal(n: int) -> String:
	match n:
		1: return "1st"
		2: return "2nd"
		3: return "3rd"
		4: return "4th"
		5: return "5th"
		_: return str(n)


func _on_borehole_layer_breached(layer: int) -> void:
	if layer <= 0 or layer >= 5:
		return
	
	label.text = """You Breached\nthe %s Shell!""" % _int_to_ordinal(layer)
	
	visible = true
	timer.start()
