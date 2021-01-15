extends Area2D


export (bool) var on = false
var energy = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", self, "_item_area_entered")
	$Label.text = str(on)
	$Label.hide()
	
	
#	$ClickArea2D.connect("input_event", self, "_inner_input_event")
#
#func _inner_input_event(viewport, event, shape_idx):
#
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and !event.pressed:
#			on = !on
#			$Label.text = str(on)
#			print("event!!!!")

func _item_area_entered(object):
	if (object.is_in_group("activator")):
		on = !on
		$Label.text = str(on)
		print("event!!!!")
	if on:
		$AnimatedSprite.play("default")
		$AnimatedSprite2.play("default")
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite2.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
