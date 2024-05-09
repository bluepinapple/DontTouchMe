extends CanvasLayer

@onready var start_button = %StartButton

func _ready():
	start_button.pressed.connect(on_start_button_pressed)
	
	
func on_start_button_pressed():
	get_tree().change_scene_to_file("res://scene/main.tscn")
