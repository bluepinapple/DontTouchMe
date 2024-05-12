extends CharacterBody2D

@onready var touch_area_2d = %TouchArea2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var check_area_2d = %CheckArea2D

func _ready():
	scale = scale * randf_range(0.9,1.1)

func _process(delta):
	if scale > Vector2(3.0,3.0):
		BulletCollisionComponent.free_the_little_one(self)
	elif scale < Vector2(0.3,0.3):
		scale = Vector2(0.3,0.3)


func get_radius():
	var radius = collision_shape_2d.shape as CircleShape2D
	return radius.radius * scale.x * collision_shape_2d.scale.x
