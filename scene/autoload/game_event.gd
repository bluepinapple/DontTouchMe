extends Node

signal scale_changed

func emit_player_scale_changed(scale_amount:Vector2):
	scale_changed.emit(scale_amount)
