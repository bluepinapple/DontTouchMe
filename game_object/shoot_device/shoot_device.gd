extends Node2D

@export var bullet : PackedScene
@onready var marker_2d = %bullet_spwan_spot

func shoot():
	var bullets_layer = get_tree().get_first_node_in_group("bullets_layer")
	if bullets_layer == null:
		return
	var bullet_instance = bullet.instantiate() as CharacterBody2D
	
	bullets_layer.add_child(bullet_instance)
	bullet_instance.max_speed = 600
	bullet_instance.acceleration = 100
	bullet_instance.global_position = marker_2d.global_position
	bullet_instance.accelerate_to_player(marker_2d.global_position)
