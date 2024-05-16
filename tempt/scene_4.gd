extends Node
@onready var animation_player = $AnimationPlayer
@onready var game_camera = $Entities/GameCamera
@onready var friend = preload("res://tempt/friend_device.tscn")

func _ready():
	game_camera.zoom = Vector2(.01,0.01)
	await get_tree().create_timer(.5).timeout
	animation_player.play("in")
	Music.change_music()
	
	if GameEvent.pause_count != 0:
		var friend_instance = friend.instantiate() as CharacterBody2D
		var entities_layer = get_tree().get_first_node_in_group("entities_layer")
		entities_layer.add_child(friend_instance)
		friend_instance.global_position = Vector2(200,200)
		friend_instance.distance_to_player = 10
	else :
		var friend_instance = friend.instantiate() as CharacterBody2D
		var entities_layer = get_tree().get_first_node_in_group("entities_layer")
		entities_layer.add_child(friend_instance)
		friend_instance.global_position = Vector2(200,200)
		friend_instance.distance_to_player = 10
