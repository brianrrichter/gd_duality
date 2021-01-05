extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (bool) var destroy_on_contact = true

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_body_entered")
	pass # Replace with function body.

func _on_body_entered(object):
	print("TESTETT")
	if destroy_on_contact:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
