extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var energy = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	$ExpireTimer.connect("timeout", self, "_on_expire")
	pass # Replace with function body.

func _on_expire():
	queue_free()

func destroy():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
