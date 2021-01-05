extends KinematicBody2D

const UNIT_SIZE = 16

var run_speed = 6 * UNIT_SIZE
var jump_speed = -8 * UNIT_SIZE
var velocity = Vector2()
var jumping = false
var gravity = 200

var current_energy = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$ItemsArea2D.connect("area_entered", self, "_item_area_entered")
	$EnergyTimer.connect("timeout", self, "_on_energy_timer_expire")
	pass # Replace with function body.

func _physics_process(delta):
#	var snap = Vector2.DOWN * PLAYER_VARIABLES.UNIT_SIZE / 2 if !is_jumping else Vector2.ZERO
#	var snap = Vector2.ZERO
	
	var local_gravity = gravity
	var local_run_speed = run_speed
	
	if -1 > current_energy:
		local_run_speed = run_speed * 2
	elif 0 > current_energy:
		local_run_speed = run_speed / 3
	if current_energy > 1 and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	elif (!jumping) and current_energy > 0:
		local_gravity = 1
	
	
	
	velocity.x = local_run_speed
	
	velocity.y += delta * local_gravity
	
#	$Label.text = str("Velocity: ", velocity)
#	$Label.text = str("Jumping: ", jumping)
	
	
#	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if jumping and is_on_floor():
		jumping = false
	
	$Label.text = str(current_energy)

func _item_area_entered(object):
#	print(object)
	
	if (object.is_in_group("harm")):
		$Label.text = "PERDEU!"
#		get_tree().paused = true
#		PhysicsServer.set_active(false)
		set_physics_process(false)
	if (object.is_in_group("goal")):
		$Label.text = "VENCEU!"
#		get_tree().paused = true
		set_physics_process(false)
	elif (object.is_in_group("interation_point")):
		
		if object.energy > 0 and current_energy < 0:
			current_energy = 0
		
		if object.energy < 0 and current_energy > 0:
			current_energy = 0
		
		current_energy += object.energy
		
		$EnergyTimer.start()
		
		print(current_energy)
		
		object.destroy()
	
	pass

func _on_energy_timer_expire():
	print("TIMERRRR!", current_energy)

	if current_energy != 0:
		current_energy = 0
#	if current_energy > 0 :
#		current_energy = current_energy -1
#	elif current_energy < 0:
#		current_energy = current_energy + 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
