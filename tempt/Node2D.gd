extends Node2D

@onready var label = $PauseLabel

@export var friend : PackedScene

var text_arrey = ["一个人对抗世界也是会疲惫的时候","还好我们一起就会有力量","接收我的力量吧！"]
var i = 0


func _ready():
	label.text = ""
	GameEvent.first_pause.connect(on_first_pause)
	

func _input(event):
	if event.is_action_pressed("continue") && i != 0:
		label.text = text_arrey[i]
		i += 1
		if i >= text_arrey.size():
			get_tree().paused = false
			var friend_instance = friend.instantiate() as CharacterBody2D
			var entities_layer = get_tree().get_first_node_in_group("entities_layer")
			var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
			entities_layer.add_child(friend_instance)
			friend_instance.global_position = player.global_position + Vector2(-500,0)
	elif i == 3:
		queue_free()


func on_first_pause():
	label.text = text_arrey[i]
	i += 1
	
