extends CharacterBody2D

@onready var touch_area_2d = %TouchArea2D
@onready var collision_shape_2d = $TouchArea2D/CollisionShape2D
@onready var check_area_2d = %CheckArea2D
@onready var check_collision= $CheckArea2D/CollisionShape2D
@onready var collision = $CollisionShape2D

func _ready():
	#await get_tree().create_timer(.1).timeout
	#print(check_area_2d.get_overlapping_areas().is_empty())
	scale = scale * randf_range(0.9,1.1)
	await get_tree().create_timer(1).timeout

func _process(delta):
	#print("ready",check_area_2d.get_overlapping_areas().size(),check_area_2d.get_overlapping_bodies().size())
	#print(check_area_2d.get_overlapping_areas().size())
	if scale > Vector2(3.0,3.0):
		BulletCollisionComponent.bomb_bigger(self)


func set_collision_disabled():
	collision_shape_2d.disabled = true
	collision.disabled = true
	check_collision.disabled = true


func get_radius():
	var radius = collision_shape_2d.shape as CircleShape2D
	return radius.radius * scale.x * collision_shape_2d.scale.x
	

func switch_enable_touch():
	collision_shape_2d.disabled = !collision_shape_2d.disabled
	
func set_collision_shape_2d_state(state:bool):
	collision_shape_2d.disabled = state

func try_to_spwan(death_position:Vector2):
	var spwan_succed = 0
	
	var random_rotation = Vector2.RIGHT.rotated(randf_range(0,TAU))*randf_range(10,80)
	var spwan_position = random_rotation + death_position
	global_position = spwan_position
	scale = scale * 0.3
	await get_tree().create_timer(.1).timeout
	
	for i in 50:
		print(check_area_2d.get_overlapping_areas().is_empty())
		if i >=40:
			print("freed")
			self.queue_free()
			break
		
		if check_area_2d.get_overlapping_areas().is_empty():
			visible = true
			collision_shape_2d.disabled = false
			spwan_succed +=1
			break
		else :
			random_rotation = Vector2.RIGHT.rotated(randf_range(0,TAU))*randf_range(10,80)
			spwan_position = random_rotation + death_position
			global_position = spwan_position
			print("arrey",check_area_2d.get_overlapping_areas())
		print("i",i)
	print("succed",spwan_succed)

