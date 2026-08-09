extends Node2D

var movement_delta = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


#func _physics_process(delta: float) -> void:
	#if Input.is_action_just_pressed("Up"):
		#if movement_delta < 0:
			#movement_delta = 0
		#movement_delta += 1
	#if Input.is_action_just_pressed("Down"):
		#if movement_delta > 0:
			#movement_delta = 0
		#movement_delta -= 1
	#background.position.y += movement_delta
