extends Node2D


func _process(_delta: float) -> void:
	position = get_viewport().get_mouse_position()
