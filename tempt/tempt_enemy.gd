extends CharacterBody2D

@onready var touch_area_2d = %TouchArea2D
@onready var aviod_area_2d = %AviodArea2D
@onready var touch_collision = %TouchCollision
@onready var aviod_collision = %AviodCollision
@onready var collision_shape_2d_2 = $CollisionShape2D2

@export var max_speed = 300
@export var acceleration_smoothing = 7
@export var portal : PackedScene

var aviod_group = []

func _ready():
	scale = scale * randf_range(0.9,1.1)
	aviod_area_2d.area_entered.connect(on_aviod_area_entered)
	aviod_area_2d.area_exited.connect(on_aviod_area_exited)

func _process(delta):
	run_away(delta)
	move_and_slide()
	
	if scale > Vector2(1.6,1.6):
		var portal_instance = portal.instantiate() as Node2D
		portal_instance.scale = Vector2.ZERO
		var entities_layer = get_tree().get_first_node_in_group("entities_layer")
		entities_layer.add_child(portal_instance)
		portal_instance.global_position = global_position
		portal_instance.scale = Vector2.ONE * 8
		print(global_position)
		BulletCollisionComponent.bomb_bigger(self)
		


func set_collision_disabled():
	touch_collision.disabled = true
	aviod_collision.disabled = true
	collision_shape_2d_2.disabled = true


func set_collision_shape_2d_state(state:bool):
	touch_collision.disabled = state
	

func get_radius():
	var radius = touch_collision.shape as CircleShape2D
	return radius.radius * scale.x* touch_collision.scale.x


func run_away(delta):
	if aviod_group.size() == 0:
		velocity =velocity.lerp(Vector2.ZERO,1-exp(-delta*acceleration_smoothing))
	else :
		var direction = get_movement_vector()
		var target_velocity = direction * max_speed
		
		velocity = velocity.lerp(target_velocity,1-exp(-delta*acceleration_smoothing))


func get_movement_vector():
	#var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	#if player == null:
		#return
	#var dir = (-player.global_position + global_position).normalized()
	#return dir
	
	var dir = Vector2.ZERO
	if aviod_group.size() == 0:
		return dir
	var self_position = self.global_position
	for i in aviod_group:
		dir = dir + (self_position - i.global_position).normalized()
	return dir
	
	
func on_aviod_area_entered(other_area:Node2D):
	print("1")
	var other = other_area.get_parent() as Node2D
	aviod_group.append(other)


func on_aviod_area_exited(other_area : Node2D):
	for other in aviod_group:
		if other == other_area.get_parent():
			aviod_group.erase(other)
		else :
			continue


