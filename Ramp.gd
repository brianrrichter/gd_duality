extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var curr_direction = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	$StaticBody2D/Area2D.connect("area_entered", self, "_item_area_entered")
#	$Tween.interpolate_property($StaticBody2D, "rotation_degrees", 0, 45 * curr_direction, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

func _item_area_entered(object):
	print("EEEEEE")
	if (object.is_in_group("activator")):
		curr_direction = curr_direction * -1
		if (curr_direction < 0) :
			$Tween.interpolate_property($StaticBody2D, "rotation_degrees", 0, -45, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		else:
			$Tween.interpolate_property($StaticBody2D, "rotation_degrees", -45, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		
