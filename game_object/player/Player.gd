extends CharacterBody2D

@export var max_speed = 400
@export var acceleration_smoothing = 100
@onready var area_2d = $Area2D
@onready var visuals = $Visuals as Node2D
@onready var hurt_shape_2d = %hurtShape2D

func _ready():
	GameEvent.scale_changed.connect(on_player_scale_changed)
	area_2d.area_entered.connect(on_body_entered)
	

func _process(delta):
	var direction = get_movement_vecter()
	var target_velocity = direction * max_speed
	
	velocity = velocity.lerp(target_velocity,1-exp(-delta*acceleration_smoothing))
	
	#print(damage_interval_timer.wait_time)
	move_and_slide()
	
	var move_sign = sign(direction.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign,1)

func get_radius():
	var circle_shape = hurt_shape_2d.shape as CircleShape2D
	return circle_shape.radius

func get_movement_vecter():
	
	var x_movement = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down")-Input.get_action_strength("move_up")
	
	return Vector2(x_movement,y_movement).normalized()


func on_body_entered(other_node : Node2D):
	var other = other_node.get_parent() as CharacterBody2D
	if other == null:
		return
	GameEvent.emit_player_scale_changed(other.scale)


func on_player_scale_changed(scale_amount:Vector2):
	var scale_increase = scale + scale_amount
	var tween = create_tween()
	tween.tween_property(self,"scale",scale_increase,.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	if scale > Vector2(3.0,3.0):
		scale = Vector2(3.0,3.0)
	elif scale < Vector2(0.3,0.3):
		scale = Vector2(0.3,0.3)
