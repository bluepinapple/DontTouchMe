extends StaticBody2D

@onready var right_area_2d = %RightArea2D
@onready var up_area_2d = %UpArea2D
@onready var down_area_2d = %DownArea2D
@onready var left_area_2d = %LeftArea2D

#func _ready():
	#right_area_2d.area_entered.connect(on_right_area_entered)
	#left_area_2d.area_entered.connect(on_left_area_entered)
	#up_area_2d.area_entered.connect(on_up_area_entered)
	#down_area_2d.area_entered.connect(on_down_area_entered)
	#
#
#func on_right_area_entered(other_area:Node2D):
	#var other = other_area.get_parent() as CharacterBody2D
	#if other.is_in_group("bullet") || other.is_in_group("player_bullet"):
		#var bounce_dir = Vector2(1,-1)
		#other.desired_velocity = other.desired_velocity * bounce_dir
		#other.accelerate_straight(other.desired_velocity/other.max_speed)
		#print("1")
#
#
#func on_left_area_entered(other_area:Node2D):
	#var other = other_area.get_parent()
	#if other.is_in_group("bullet") || other.is_in_group("player_bullet"):
		#var bounce_dir = Vector2(1,-1)
		#other.desired_velocity = other.desired_velocity * bounce_dir
		#other.accelerate_straight(other.desired_velocity/other.max_speed)
		#print("2")
#
#
#func on_up_area_entered(other_area:Node2D):
	#var other = other_area.get_parent()
	#if other.is_in_group("bullet") || other.is_in_group("player_bullet"):
		#var bounce_dir = Vector2(-1,1)
		#other.desired_velocity = other.desired_velocity * bounce_dir
		#other.accelerate_straight(other.desired_velocity/other.max_speed)
		#print("3")
#
#
#func on_down_area_entered(other_area:Node2D):
	#var other = other_area.get_parent()
	#if other.is_in_group("bullet") || other.is_in_group("player_bullet"):
		#var bounce_dir = Vector2(-1,1)
		#other.desired_velocity = other.desired_velocity * bounce_dir
		#other.accelerate_straight(other.desired_velocity/other.max_speed)
		#print("4")
