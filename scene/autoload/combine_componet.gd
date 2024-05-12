extends Node

@export var touch_area : Area2D

func _ready():
	touch_area.area_entered.connect(on_area_entered)


func get_radius():
	if owner == null:
		return
	
	return touch_area.owner.get_radius()


func on_area_entered(other:Node2D):
	var other_radius = other.owner.get_radius()
	var self_radius = get_radius()
	
	var is_owner_player = owner.is_in_group("player")
	var is_other_player = other.owner.is_in_group("player")
	var is_owner_enemy = owner.is_in_group("enemy")
	var is_other_enmey = other.owner.is_in_group("enemy")
	
	if is_owner_player || is_other_player:
		if is_other_player && is_owner_player:
			return
		elif is_owner_player:
			scale_increas(self_radius,other_radius)
		else :
			BulletCollisionComponent.free_the_little_one(owner)
	else :
		if is_owner_enemy || is_other_enmey:
			if is_owner_enemy && (!is_other_enmey):
				scale_increas(self_radius,other_radius)
			elif (!is_owner_enemy) && is_other_enmey:
				BulletCollisionComponent.free_the_little_one(owner)
			else :
				if other_radius < self_radius:
					scale_increas(self_radius,other_radius)
				elif other_radius > self_radius:
					BulletCollisionComponent.free_the_little_one(owner)
				else :
					BulletCollisionComponent.free_the_little_one(owner)
		else :
			if other_radius < self_radius:
				scale_increas(self_radius,other_radius)
			elif other_radius > self_radius:
				BulletCollisionComponent.free_the_little_one(owner)
			else :
				BulletCollisionComponent.free_the_little_one(owner)


func scale_increas(self_radius:float,other_radius:float):
	var increas_percent = (other_radius+self_radius) / self_radius
	if owner == null:
		return
	var result_scale = owner.scale * increas_percent
	var tween = create_tween()
	tween.tween_property(owner,"scale",result_scale,.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
