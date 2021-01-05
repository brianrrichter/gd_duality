extends Node2D

var IPointScene = preload("res://IterationPoint.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE and event.pressed == false:
		get_tree().quit()
	if event is InputEventKey and event.scancode == KEY_R and event.pressed == false:
		get_tree().reload_current_scene()
	if event is InputEventMouseButton \
			and (event.button_index == BUTTON_LEFT or event.button_index == BUTTON_RIGHT) \
			and event.pressed:
		var iPoint = IPointScene.instance()
		iPoint.energy = 1 if event.button_index == BUTTON_LEFT else -1
		iPoint.global_position = get_global_mouse_position()
		add_child(iPoint)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
