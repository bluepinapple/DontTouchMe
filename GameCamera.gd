extends Camera2D

var target_position = Vector2.ZERO
var offset_position = Vector2.ZERO

func _ready():
	GameEvent.change_camera_zoom.connect(on_zoom_changed)
	GameEvent.first_pause.connect(on_first_pause)
	make_current()


func _process(delta):
	acquire_target_position()
	global_position = global_position.lerp(target_position,1.0-exp(-delta*10))
	

func acquire_target_position():
	var player_node = get_tree().get_first_node_in_group("player") as CharacterBody2D
	if player_node != null :
		target_position = player_node.global_position + offset_position

func camera_zoom_in():
	#zoom = Vector2(2.0,2.0)
	var tween = create_tween()
	tween.tween_property(self,"zoom",Vector2(2.0,2.0),0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)

func camera_zoom_back():
	var tween = create_tween()
	tween.tween_property(self,"zoom",Vector2.ONE,0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)


func camera_zoom_out():
	var tween = create_tween()
	tween.tween_property(self,"zoom",Vector2(.5,.5),0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)


func on_zoom_changed():
	var player_node = get_tree().get_first_node_in_group("player") as CharacterBody2D
	if player_node.scale > Vector2(3.0,3.0):
		camera_zoom_out()
	elif player_node.scale < Vector2(.5,.5):
		camera_zoom_in()
	else :
		camera_zoom_back()


func on_first_pause():
	get_tree().paused = true
	offset_position = Vector2(-200,0)
	var tween = create_tween()
	tween.tween_property(self,"global_position",target_position,0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
