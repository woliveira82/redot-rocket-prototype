extends Node2D

@export var _rocket_scene: PackedScene
@export var _target: Node2D


func _ready() -> void:
	InputHandler.on_button_pressed.connect(_launch_rocket)


func _launch_rocket() -> void:
	var rocket = _rocket_scene.instantiate()
	get_tree().current_scene.add_child(rocket)
	rocket.global_position = global_position
	rocket.set_target(_target)


func _on_timer_timeout() -> void:
	_launch_rocket()
