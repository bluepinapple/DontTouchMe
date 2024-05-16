extends Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var area_2d = $"../Area2D"
@onready var animation_player = $"../AnimationPlayer"

func _ready():
	area_2d.area_entered.connect(on_area_entered)
	area_2d.area_exited.connect(on_area_entered)


func on_area_entered(other_area : Node2D):
	animation_player.play("shink")
