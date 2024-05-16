extends Node

@onready var slime_scene = preload("res://game_object/static_slime/static_slime.tscn")

func free_the_little_one(little_one : Node2D):
	var tween = create_tween()
	tween.tween_property(little_one,"scale",Vector2.ZERO,.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(Callable(queue_free_little_one).bind(little_one))


func queue_free_little_one(little_one : Node2D):
	little_one.queue_free()


func bomb_bigger(bomb:Node2D):
	#var spwan_position = bomb.global_position
	bomb.set_collision_disabled()
	if bomb.is_in_group("player_bullet") || bomb.is_in_group("bullet"):
		var tween = create_tween()
		tween.tween_property(bomb.sprite_2d,"scale",Vector2.ZERO,.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_callback(Callable(drop_slime).bind(bomb))
	else :
		var tween = create_tween()
		tween.tween_property(bomb,"scale",Vector2.ZERO,.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_callback(Callable(drop_slime).bind(bomb))

	

func drop_slime(bomb:Node2D):
	var death_position = bomb.global_position
	bomb.queue_free()
	if death_position == null:
		return
	#print(slime_scene)
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	if entities_layer == null:
		return
	for i in randi_range(1,3):
		await get_tree().create_timer(randf_range(.1,.3)).timeout
		var slime_instance = slime_scene.instantiate() as Node2D
		entities_layer.add_child(slime_instance)
		slime_instance.visible = false
		slime_instance.set_collision_shape_2d_state(true)
		#slime_instance.switch_enable_touch()
		slime_instance.try_to_spwan(death_position)
		#await get_tree().create_timer(.1).timeout
	
	
