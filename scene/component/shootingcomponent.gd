extends Node2D

@onready var hand = %Hand as CharacterBody2D
@onready var north = %North
@onready var south = %South
@onready var east = %East
@onready var west = %West
@onready var northwest = %Northwest
@onready var northeast = %Northeast
@onready var southwest = %Southwest
@onready var southeast = %Southeast
@onready var finger_top = %FingerTop
@onready var center = %Center

@export var bullet : PackedScene
@export var max_speed = 600
@export var acceleration : float = 150

var is_shooting = false

func _process(delta):
	accelerate_to_target(hand.global_position)
	hand.move_and_slide()
	
	shoot_bullet()
	

func shoot_bullet():
	if is_shooting == false:
		var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
		if get_shoot_vecter() != Vector2.ZERO && hand.global_position.distance_to(center.global_position)>100*player.scale.x:
			if player.scale <= Vector2(0.3,0.3):
				return
			is_shooting = true
			var bullet_instance = bullet.instantiate() as CharacterBody2D
			var bullet_layer = get_tree().get_first_node_in_group("bullets_layer")
			if bullet_layer == null:
				return
			bullet_layer.add_child(bullet_instance)
			bullet_instance.global_position = finger_top.global_position
			bullet_instance.scale = bullet_instance.scale * player.scale.x
			bullet_instance.accelerate_straight(get_shoot_vecter().normalized())
			get_tree().create_timer(.2).timeout.connect(on_timer_timeout)
			GameEvent.emit_player_scale_changed(-bullet_instance.scale*.1)

func get_shoot_vecter():
	
	var x_shoot_dir = Input.get_action_strength("shoot_right")-Input.get_action_strength("shoot_left")
	var y_shoot_dir = Input.get_action_strength("shoot_down")-Input.get_action_strength("shoot_up")
	
	return Vector2(x_shoot_dir,y_shoot_dir)
	
func accelerate_to_target(start_posistion : Vector2):
	if owner == null :
		return
	var owner_node2d = owner as Node2D
	var shoot_dir = get_shoot_vecter()
	
	var target : Vector2 = Vector2.ZERO
	if shoot_dir == Vector2(0,0):
		target = owner_node2d.global_position
		hand.global_rotation_degrees = 45
	elif shoot_dir == Vector2(1,1):
		target = southeast.global_position
		hand.global_rotation_degrees = 90
	elif shoot_dir == Vector2(1,0):
		target = east.global_position
		hand.global_rotation_degrees = 45
	elif shoot_dir == Vector2(0,1):
		target = south.global_position
		hand.global_rotation_degrees = 135
	elif shoot_dir == Vector2(-1,-1):
		target = northwest.global_position
		hand.global_rotation_degrees = -90
	elif shoot_dir == Vector2(-1,0):
		target = west.global_position
		hand.global_rotation_degrees = -135
	elif shoot_dir == Vector2(0,-1):
		target = north.global_position
		hand.global_rotation_degrees = -45
	elif shoot_dir == Vector2(1,-1):
		target = northeast.global_position
		hand.global_rotation_degrees = 0
	elif shoot_dir == Vector2(-1,1):
		target = southwest.global_position
		hand.global_rotation_degrees = 180
	
	var direction = (target - start_posistion).normalized()
	accelerate_in_direction(direction)

func accelerate_in_direction(direction:Vector2):
	var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	var desired_velocity = direction * max_speed*player.scale
	hand.velocity = hand.velocity.lerp(desired_velocity , 1-exp(-acceleration * get_process_delta_time()))


func on_timer_timeout(): 
	is_shooting = false
