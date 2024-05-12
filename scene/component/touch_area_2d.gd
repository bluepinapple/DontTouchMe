extends Area2D
class_name TouchArea

@onready var touch_collision = %TouchCollision

@export_range(0,100) var radius 
@export var sprite : PackedScene


func get_radius():
	var cicle_shape = touch_collision.shape as CircleShape2D
	return cicle_shape.radius
