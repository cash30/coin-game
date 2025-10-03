extends CharacterBody2D

@export var speed: float = 75.0
@export var detection_range: float = 1000.0
@export var jumpVelocity = -300.0

var player: Node2D
var direction: Vector2 = Vector2.ZERO

func _ready():
	# Assumes the player is in the same scene and named "Player"
	player = get_tree().get_first_node_in_group("player")  # Better if you use groups

func _physics_process(delta):
	
	
	
	
	if not player:
		print("Can't find player. ending enimie movement process")
		return

	var distance_to_player = global_position.distance_to(player.global_position)

	if distance_to_player <= detection_range:
		direction = (player.global_position - global_position).normalized()
		velocity.x = direction.x * speed
		#print("going to player")
		#print("Direction:", direction.x, "Velocity X:", velocity.x)

	else:
		velocity.x = 0 
		pass
		
	if is_on_floor():
		velocity.y = jumpVelocity * -direction.y
		
	if not is_on_floor():
		velocity += get_gravity() * delta  
		
		


		
	move_and_slide()
