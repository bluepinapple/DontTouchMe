extends CharacterBody2D

@export var max_speed :int = 500
@export var acceleration : float = 200

@onready var area_2d = $Area2D as Area2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var collision = $CollisionShape2D


func _ready():
	scale = scale * randf_range(0.9,1.1)


func _process(delta):
	if scale > Vector2(3.0,3.0):
		BulletCollisionComponent.bomb_bigger(self)


func _physics_process(delta):
	move_and_slide()
	get_tree().create_timer(5).timeout.connect(func on_timer_timeout():queue_free())
	
func set_collision_shape_2d_state(state:bool):
	collision_shape_2d.disabled = state


func set_collision_disabled():
	collision_shape_2d.disabled = true
	collision.disabled = true


func get_radius():
	var radius = collision_shape_2d.shape as CircleShape2D
	return radius.radius * scale.x* collision_shape_2d.scale.x

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

