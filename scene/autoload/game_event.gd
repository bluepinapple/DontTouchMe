extends Node

signal scale_changed
var i = 1

func emit_player_scale_changed(amount:float):
	i += 1
	print(i)
	scale_changed.emit(amount)
