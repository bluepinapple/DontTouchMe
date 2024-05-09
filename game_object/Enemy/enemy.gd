extends CharacterBody2D

@onready var touch_area_2d = %TouchArea2D

@export var max_speed = 300
@export var acceleration_smoothing = 5

var is_running = false

func _ready():
	touch_area_2d.area_entered.connect(on_touch_area_entered)


func _process(delta):
	var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	if player != null:
		if player.global_position.distance_to(global_position)<300 :
			is_running = true
		if player.global_position.distance_to(global_position) > 600:
			is_running = false
	run_away(delta)
	move_and_slide()


func on_touch_area_entered(other_area : Node2D):
	var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	if other_area == player.area_2d:
		queue_free()
	
	scale *= 1.15
	if scale > Vector2(3.0,3.0):
		queue_free()
	elif scale < Vector2(0.3,0.3):
		scale = Vector2(0.3,0.3)
	

func run_away(delta):
	if is_running == true:
		var direction = get_movement_vector()
		var target_velocity = direction * max_speed
	
		velocity = velocity.lerp(target_velocity,1-exp(-delta*acceleration_smoothing))
	else : 
		velocity = velocity.lerp(Vector2.ZERO,1-exp(-delta*acceleration_smoothing))
		


func get_movement_vector():
	var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	if player == null:
		return
	var dir = (-player.global_position + global_position).normalized()
	return dir
	
