extends RigidBody2D

@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var sprite_2d = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var area_2d = $Area2D

func _ready():
	initiate_scale()


func _process(delta):
	if sprite_2d.scale > Vector2(3.0,3.0):
		BulletCollisionComponent.bomb_bigger(self)
	
	get_tree().create_timer(8).timeout.connect(func on_timer_timeout():queue_free())


func get_radius():
	var radius = collision_shape_2d.shape as CircleShape2D
	return radius.radius * sprite_2d.scale.x * collision.scale.x


func initiate_scale():
	var random_number = randf_range(0.9,1.1)
	sprite_2d.scale *= random_number
	collision_shape_2d.scale *= random_number
	collision.scale *= random_number


func set_collision_disabled():
	collision_shape_2d.disabled = true
	collision.disabled = true


func set_all_scale(player_scale:Vector2):
	#print("in",player_scale)
	if player_scale<Vector2(.2,.2):
		player_scale = Vector2(.2,.2)
	sprite_2d.scale *= player_scale
	#collision_shape_2d.scale *= player_scale
	collision.scale *= player_scale
	#print("out",player_scale)
