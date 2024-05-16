extends AudioStreamPlayer2D

func _ready():
	play()
	finished.connect(on_finished)
	$Timer.timeout.connect(on_timer_timeout)
	

func on_finished():
	$Timer.start()
	
	
func on_timer_timeout():
	play()

func change_music():
	stream = load("res://tempt/Champ de tournesol.mp3")
	play()
