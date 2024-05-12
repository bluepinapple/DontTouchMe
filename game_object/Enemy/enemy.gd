extends CharacterBody2D

@onready var touch_area_2d = %TouchArea2D
@onready var aviod_area_2d = %AviodArea2D
@onready var touch_collision = %TouchCollision

@export var max_speed = 300
@export var acceleration_smoothing = 6

var aviod_group = []

func _ready():
	scale = scale * randf_range(0.9,1.1)
	aviod_area_2d.area_entered.connect(on_aviod_area_entered)
	aviod_area_2d.area_exited.connect(on_aviod_area_exited)

func _process(delta):
	run_away(delta)
	move_and_slide()
	if scale > Vector2(3.0,3.0):
		BulletCollisionComponent.free_the_little_one(self)
	elif scale < Vector2(0.3,0.3):
		scale = Vector2(0.3,0.3)
	
func get_radius():
	var radius = touch_collision.shape as CircleShape2D
	return radius.radius * scale.x* touch_collision.scale.x


func run_away(delta):
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
	var other = other_area.get_parent() as CharacterBody2D
	aviod_group.append(other)


func on_aviod_area_exited(other_area : Node2D):
	for other in aviod_group:
		if other == other_area.get_parent():
			aviod_group.erase(other)
		else :
			continue


