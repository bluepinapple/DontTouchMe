extends CharacterBody2D

@export var max_speed :int = 500
@export var acceleration : float = 200
@onready var area_2d = $Area2D

func _ready():
	area_2d.area_entered.connect(on_body_entered)


func _physics_process(delta):
	move_and_slide()
	get_tree().create_timer(5).timeout.connect(func on_timer_timeout():queue_free())
	

func accelerate_straight(direction : Vector2):
	var desired_velocity = direction * max_speed
	velocity = velocity.lerp(desired_velocity , 1-exp(-acceleration * get_process_delta_time()))


func accelerate_to_player(start_posistion : Vector2):	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var direction = (player.global_position - start_posistion).normalized()
	accelerate_in_direction(direction)


func accelerate_in_direction(direction:Vector2):
	var desired_velocity = direction * max_speed
	velocity = velocity.lerp(desired_velocity , 1-exp(-acceleration * get_process_delta_time()))

func on_body_entered(other_body:Node2D):
	var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	var node_owner = other_body.get_parent()
	if node_owner == player:
		queue_free()
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		if enemy == node_owner:
			queue_free()
		else :
			continue
