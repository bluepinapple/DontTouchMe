extends Node2D

@onready var area_2d = $Area2D

func _ready():
	area_2d.area_entered.connect(on_area_entered)


func on_area_entered(other_node:Node2D):
	if other_node.owner == get_tree().get_first_node_in_group("player"):
		get_tree().change_scene_to_file("res://tempt/scene_1.tscn")
