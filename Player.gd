extends KinematicBody2D

const UNIT_SIZE = 60

var run_speed = 3 * UNIT_SIZE
var jump_speed = -4 * UNIT_SIZE
var velocity = Vector2()
var jumping = false
var gravity = 6 * UNIT_SIZE

const JUMP_DELAY = .3
var current_jump_delay = 0
var jump_started = false

var current_energy = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$ItemsArea2D.connect("area_entered", self, "_item_area_entered")
#	$ItemsArea2D.connect("area_exited", self, "_item_area_exited")
	$EnergyTimer.connect("timeout", self, "_on_energy_timer_expire")
	
	$AnimatedSprite.play("neutral_walking")
#	$Label.hide()

func _physics_process(delta):
	
	var local_gravity = gravity
	var local_run_speed = run_speed
	
	if -1 > current_energy:
		local_run_speed = run_speed * 2
	elif 0 > current_energy:
		local_run_speed = run_speed / 3
	elif 1 > current_energy:
		pass
	elif 2 > current_energy and is_on_floor():
		if !jump_started:
			current_jump_delay = JUMP_DELAY
			jump_started = true
		
		if jump_started && current_jump_delay <= 0:
			jumping = true
			velocity.y = jump_speed
			jump_started = false
#	elif 3 > current_energy and (!jumping):
#		local_gravity = 1
	
	if current_jump_delay > 0:
		current_jump_delay = current_jump_delay - (1 * delta)
	
	
	velocity.x = local_run_speed
	
	velocity.y += delta * local_gravity
	
#	$Label.text = str("Velocity: ", velocity)
#	$Label.text = str("Jumping: ", jumping)
	
#	var snap = Vector2.ZERO
	
#	var snap = Vector2.DOWN * PLAYER_VARIABLES.UNIT_SIZE / 2 if !is_jumping else Vector2.ZERO
#	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if jumping and is_on_floor():
		jumping = false
	
#	$Label.text = str(current_energy, ' | ', current_jump_delay)

func _item_area_entered(object):
#	print(object)
	
	if (object.is_in_group("harm")):
		$Label.text = "LOOSE!"
#		get_tree().paused = true
#		PhysicsServer.set_active(false)
		set_physics_process(false)
	if (object.is_in_group("goal")):
		$Label.text = "WON!"
#		get_tree().paused = true
		set_physics_process(false)
	elif (object.is_in_group("interation_point")):
		
		if object.energy > 0 and current_energy < 0:
			set_current_energy(0)
		
		if object.energy < 0 and current_energy > 0:
			set_current_energy(0)
		
		set_current_energy(current_energy + object.energy)
		
		$EnergyTimer.start()
		
		print(current_energy)
		if false:
			object.destroy()
	elif (object.is_in_group("interation_box")):
		if object.on and current_energy < 0:
			set_current_energy(0)
		if !object.on and current_energy > 0:
			set_current_energy(0)

		set_current_energy(current_energy + 1 if object.on else current_energy - 1)
		$EnergyTimer.start()
	

#func _item_area_exited(object):
#	if (object.is_in_group("interation_box")):
#		if object.on and current_energy < 0:
#			current_energy = 0
#		if !object.on and current_energy > 0:
#			current_energy = 0
#
#		current_energy = current_energy + 0 if object.on else current_energy - 1
#		$EnergyTimer.start()


func _on_energy_timer_expire():
	print("TIMERRRR!", current_energy)

	if current_energy != 0:
		set_current_energy(0)
#	if current_energy > 0 :
#		current_energy = current_energy -1
#	elif current_energy < 0:
#		current_energy = current_energy + 1

func set_current_energy(var energy):
	if current_energy != energy:
		if energy == -1:
			$AnimatedSprite.play("sad_walking")
		elif energy == 1:
			$AnimatedSprite.play("happy_walking")
		else:
			$AnimatedSprite.play("neutral_walking")
		
		current_energy = energy


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
