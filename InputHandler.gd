extends Node

signal on_button_pressed


func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.pressed:
            on_button_pressed.emit()
