extends Node

@export var slime_scene : PackedScene


func free_the_little_one(little_one : CharacterBody2D):
	var tween = create_tween()
	tween.tween_property(little_one,"scale",Vector2.ZERO,.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(Callable(queue_free_little_one).bind(little_one))


func queue_free_little_one(little_one : CharacterBody2D):
	if little_one.is_in_group("enemy") || little_one.is_in_group("static_slime"):
		drop_slime(little_one.global_position)
	little_one.queue_free()


func drop_slime(spwan_position:Vector2):
	if spwan_position == null:
		return
	var slime_instance = slime_scene.instantiate() as CharacterBody2D
	slime_instance.visible = false
	slime_instance.global_position = spwan_position
	

