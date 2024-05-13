extends CharacterBody2D

@export var bullet : PackedScene
@onready var marker_2d = %bullet_spwan_spot
@onready var touch_collision = %TouchCollision

func _process(delta):
	if scale > Vector2(10.0,10.0):
		BulletCollisionComponent.bomb_bigger(self)
	elif scale < Vector2(0.1,0.1):
		scale = Vector2(0.1,0.1)


func get_radius():
	var radius = touch_collision.shape as CircleShape2D
	return radius.radius * scale.x * touch_collision.scale.x

func shoot():
	var bullets_layer = get_tree().get_first_node_in_group("bullets_layer")
	if bullets_layer == null:
		return
	var bullet_instance = bullet.instantiate() as Node2D
	
	bullets_layer.add_child(bullet_instance)
	bullet_instance.max_speed = 600
	bullet_instance.acceleration = 100
	bullet_instance.global_position = marker_2d.global_position
	bullet_instance.accelerate_to_player(marker_2d.global_position)
