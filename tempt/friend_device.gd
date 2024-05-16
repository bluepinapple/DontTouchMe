extends CharacterBody2D

@export var bullet : PackedScene
@onready var marker_2d = %bullet_spwan_spot
@onready var touch_collision = %TouchCollision

var distance_to_player = 800

func _process(delta):
	if scale > Vector2(10.0,10.0):
		scale = Vector2(10.0,10.0)


func get_radius():
	var radius = touch_collision.shape as CircleShape2D
	return radius.radius * scale.x * touch_collision.scale.x

func shoot():
	var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	if player.global_position.distance_to(global_position) < distance_to_player:
		var bullets_layer = get_tree().get_first_node_in_group("bullets_layer")
		if bullets_layer == null:
			return
		var bullet_instance = bullet.instantiate() as Node2D
		
		bullets_layer.add_child(bullet_instance)
		#bullet_instance.max_speed = 600
		#bullet_instance.acceleration = 100
		bullet_instance.global_position = marker_2d.global_position
		#bullet_instance.accelerate_to_player(marker_2d.global_position)
		bullet_instance.apply_impulse(get_shoot_vecter().normalized()*800,Vector2.ZERO)
	else :
		return


func get_shoot_vecter():
	var shoot_vec = Vector2.ZERO
	var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	shoot_vec = player.global_position - marker_2d.global_position
	return shoot_vec
