extends Node

signal player_scale_changed

func emit_player_scale_changed(other_node:CharacterBody2D):
	player_scale_changed.emit(other_node)
