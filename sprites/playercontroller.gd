extends CharacterBody2D


@export var walkingspeed = 100
@export var runningSpeed = 250
@export var jumpVelocity = -300.0
@export var staminaMax = 5
@export var staminaRefillTime = 10
var speed
var stamina = 5
var canRun = true
var isTired = false
var isDead = false
func _physics_process(delta: float) -> void:
	#handle stamina
	stamina = clampf(stamina, 0, staminaMax)
	
	if stamina > 4.9:
		isTired = false
	else: if stamina < 0.1:
		isTired = true
	canRun = !isTired
		
	#handle runnung
	var isRunning = Input.is_action_pressed("run") and canRun
	if isRunning: 
		speed = runningSpeed
		stamina -= 1 * delta
		$HealthBar.value = stamina
	else:
		speed = walkingspeed
		stamina += (staminaMax/(staminaRefillTime+0.01)) * delta
		$HealthBar.value = stamina

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jumpVelocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move-left", "move-right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0,speed)

	move_and_slide()


func _on_area_2d_area_entered(_area):
		print("player died");
		isDead = true
		Globals.isDead = true
		
		
