extends Node

@onready var friend = preload("res://tempt/friend_device.tscn")

func _ready():
	if GameEvent.pause_count != 0:
		var friend_instance = friend.instantiate() as CharacterBody2D
		var entities_layer = get_tree().get_first_node_in_group("entities_layer")
		entities_layer.add_child(friend_instance)
		friend_instance.global_position = Vector2(200,200)
