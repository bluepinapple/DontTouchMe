extends Node2D

@onready var label = $Label
@onready var animation_player = $AnimationPlayer

var intro_text : Array = ["（按空格或者回车继续）","豪！我准备一个惊喜!","请找到传送门⬇，传送门会带你去到那里"]
var move_intro : Array = []
var shoot_intro : Array = []
var attack_enemy : Array = []

var i 

func _ready():
	i = 0
	show_next_text()


func _input(event):
	if event.is_action_pressed("continue"):
		animation_player.play("fade_out")
		await animation_player.animation_finished


func show_next_text():
	if i <= intro_text.size()-1:
		label.text = intro_text[i]
		i += 1
	else :
		get_tree().change_scene_to_file("res://tempt/scene_1.tscn")
