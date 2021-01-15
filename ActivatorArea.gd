extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	global_position = get_global_mouse_position()
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		$CollisionShape2D.disabled = false
	else:
		$CollisionShape2D.disabled = true
