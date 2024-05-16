extends Node

signal player_scale_changed
signal change_camera_zoom
signal first_pause

var pause_count = 0

func emit_player_scale_changed(other_node:Node2D):
	player_scale_changed.emit(other_node)

func emit_change_camera_zoom():
	change_camera_zoom.emit()


func emit_frist_pause():
	if pause_count == 0:
		first_pause.emit()
		pause_count += 1
