extends Node2D

const MAX_SPEED := 120.0
const MANUVER_SPEED := 120.0
const DOWN_ANGLE := 1.57079637050629

var _speed := MAX_SPEED
var _active := false
var _target: Node2D
var _angle: float = 0.0

@onready var area_2d: Area2D = $Area2D
@onready var smoke_particles: CPUParticles2D = $SmokeParticles
@onready var explosion_particles: CPUParticles2D = $ExplosionParticles
@onready var fragments_particles: CPUParticles2D = $FragmentsParticles
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var destroy_timer: Timer = $DestroyTimer


func _physics_process(delta: float) -> void:
	var target_direction: float = (_target.global_position - global_position).angle()
	
	if _active:
		var angle_dif = wrapf(target_direction - _angle, -PI, PI)
		_speed = MANUVER_SPEED if abs(angle_dif) > 1 else MAX_SPEED

		if abs(angle_dif) > PI:
			angle_dif = sign(angle_dif) * PI

		rotation += angle_dif * delta
		_angle = rotation

	else:
		_angle = DOWN_ANGLE

	position += _speed * Vector2.from_angle(_angle) * delta


func set_target(target: Node2D) -> void:
	_target = target


func _on_timer_timeout() -> void:
	_active = true
	smoke_particles.emitting = true


func _on_area_2d_area_entered(_area: Area2D) -> void:
	explosion_particles.emitting = true
	fragments_particles.emitting = true
	smoke_particles.emitting = false
	_active = false
	area_2d.monitoring = false
	area_2d.monitorable = false
	sprite_2d.hide()
	destroy_timer.start()


func _on_destroy_timer_timeout() -> void:
	queue_free()
