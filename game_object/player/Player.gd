extends CharacterBody2D

@export var max_speed = 400
@export var acceleration_smoothing = 100
@onready var area_2d = $Area2D
@onready var visuals = $Visuals as Node2D
@onready var hurt_shape_2d = $Area2D/CollisionShape2D

var i : int
var f : int

func _ready():
	GameEvent.player_scale_changed.connect(on_player_scale_changed)
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
	return circle_shape.radius * scale.x * hurt_shape_2d.scale.x

func get_movement_vecter():
	
	var x_movement = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down")-Input.get_action_strength("move_up")
	
	return Vector2(x_movement,y_movement).normalized()


func check_and_change_camera():
	#print(scale)
	if scale>Vector2(3.0,3.0) && i==0:
		i += 1
		GameEvent.emit_change_camera_zoom()
	elif scale <= Vector2(3.0,3.0) && i == 1:
		i-= 1
		GameEvent.emit_change_camera_zoom()
	elif scale < Vector2(.5,.5) && f == 0:
		f += 1
		GameEvent.emit_change_camera_zoom()
		GameEvent.emit_frist_pause()
	elif scale >= Vector2(.5,.5) && f == 1:
		f -= 1
		GameEvent.emit_change_camera_zoom()


func on_body_entered(other_node : Node2D):
	var other = other_node.get_parent() as Node2D
	if other == null:
		return
	var self_radius = get_radius()
	var other_radius = other.get_radius()
	
	if other.is_in_group("player_bullet")|| other_node.is_in_group("bullet"):
		other_radius = other_radius * .8
		var increas_percent = sqrt(self_radius*self_radius + other_radius*other_radius) / self_radius
		var result_scale = scale * increas_percent
		var tween = create_tween()
		tween.tween_property(self,"scale",result_scale,.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
		if result_scale > Vector2(10,10):
		#BulletCollisionComponent.bomb_bigger(self)
			scale = Vector2(10,10)
	elif other.is_in_group("friend_bullet"):
		#print("other_radius",other_radius)
		other_radius = other_radius * 1.5
		var increas_percent = sqrt(self_radius*self_radius + other_radius*other_radius) / self_radius
		var result_scale = scale * increas_percent
		var tween = create_tween()
		tween.tween_property(self,"scale",result_scale,.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
		if result_scale > Vector2(10,10):
		#BulletCollisionComponent.bomb_bigger(self)
			scale = Vector2(10,10)
	else :
		var increas_percent = sqrt(self_radius*self_radius + other_radius*other_radius) / self_radius
		var result_scale = scale * increas_percent
		var tween = create_tween()
		tween.tween_property(self,"scale",result_scale,.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)

func on_player_scale_changed(other_node:Node2D):
	if other_node.is_in_group("player_bullet") :
		var bullet_radius = other_node.get_radius()
		var player_radius = get_radius()
		if player_radius <= bullet_radius || scale<Vector2(.1,.1):
			scale = Vector2(.1,.1)
		else :
			var increas_percent = sqrt(player_radius*player_radius - bullet_radius*bullet_radius) / player_radius
			var result_scale = scale * increas_percent
			#print(increas_percent,result_scale)
			var tween = create_tween()
			tween.tween_property(self,"scale",result_scale,.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	else :
		pass
	check_and_change_camera()
	
