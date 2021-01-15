extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var energy = -1

var side_tween_values = [0, 120]

# Called when the node enters the scene tree for the first time.
func _ready():
	
#	$FallingObjectArea2D.connect("input_event", self, "_inner_input_event")
	$FallingObjectArea2D.connect("area_entered", self, "_item_area_entered")
	
	$Tween.interpolate_property($FallingObjectArea2D, "position:y", 0, 200, .3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	$SideTween.interpolate_property($FallingObjectArea2D, "position:x", \
			side_tween_values[0], \
			side_tween_values[1], .7, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$SideTween.connect("tween_completed", self, "side_tween_completed");
	$SideTween.start()
	
	
func side_tween_completed(object, key):
	side_tween_values.invert()
	$SideTween.interpolate_property($FallingObjectArea2D, "position:x", \
			side_tween_values[0], \
			side_tween_values[1], .7, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

#func _inner_input_event(viewport, event, shape_idx):
#
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and !event.pressed:
#			print("FALLLLL")
#			$Tween.start()

func _item_area_entered(object):

	if (object.is_in_group("activator")):
		print("FALLLLL2")
		$SideTween.stop_all()
		$Tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
