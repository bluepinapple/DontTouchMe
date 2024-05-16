extends Node

@export var touch_area : Area2D

func _ready():
	touch_area.area_entered.connect(on_area_entered)


func get_radius():
	if owner == null:
		return
	
	return touch_area.owner.get_radius()

func queue_free_owner():
	owner.queue_free()


func play_queue_free_anim():
	owner.set_collision_disabled()
	var tween = create_tween()
	tween.tween_property(owner.sprite_2d,"scale",Vector2.ZERO,.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(Callable(queue_free_owner))


func on_area_entered(other:Node2D):
	var other_radius = other.owner.get_radius()
	#print("shoot",other,other_radius)
	var self_radius = get_radius()
	var is_other_player = other.owner.is_in_group("player")
	var is_other_enmey = other.owner.is_in_group("enemy")
	if  is_other_player || is_other_enmey:
		play_queue_free_anim()
	else :
		if other_radius < self_radius:
			scale_increas(self_radius,other_radius)
		else :
			play_queue_free_anim()


func scale_increas(self_radius:float,other_radius:float):
	if owner.scale >= Vector2(3.0,3.0):
		return
	else :
		var increas_percent = sqrt(self_radius*self_radius + other_radius*other_radius) / self_radius
		if owner == null:
			return
		
		var result_scale = owner.sprite_2d.scale * increas_percent
		var tween = create_tween()
		tween.tween_property(owner.sprite_2d,"scale",result_scale,.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
		owner.set_all_scale(owner.sprite_2d.scale)

