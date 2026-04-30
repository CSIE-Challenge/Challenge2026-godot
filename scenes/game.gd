extends Node2D

const ENERGY_BALL_SPAWN_INTERVAL := 5.0
const ENERGY_BALL_SCENE := preload("res://scenes/energy_ball.tscn")

@onready var map_panel: Panel = $Panel
@onready var energy_ball_counter: Label = $EnergyBallCounter

var rng := RandomNumberGenerator.new()
var spawn_timer: Timer
var collected_energy_balls := 0


func _ready() -> void:
	rng.randomize()

	spawn_energy_ball()
	update_energy_ball_counter()

	spawn_timer = Timer.new()
	spawn_timer.wait_time = ENERGY_BALL_SPAWN_INTERVAL
	spawn_timer.autostart = true
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)


func _on_spawn_timer_timeout() -> void:
	spawn_energy_ball()


func spawn_energy_ball() -> void:
	var energy_ball := ENERGY_BALL_SCENE.instantiate() as Area2D
	add_child(energy_ball)
	setup_energy_ball(energy_ball)


func setup_energy_ball(energy_ball: Area2D) -> void:
	place_energy_ball_randomly(energy_ball)
	energy_ball.collected.connect(_on_energy_ball_collected)


func place_energy_ball_randomly(energy_ball: Area2D) -> void:
	var spawn_rect := map_panel.get_global_rect()
	var collision_shape: CollisionShape2D = energy_ball.get_node("CollisionShape2D")
	var padding := Vector2.ZERO

	if collision_shape.shape is RectangleShape2D:
		padding = collision_shape.shape.size * 0.5

	var min_x := spawn_rect.position.x + padding.x
	var max_x := spawn_rect.end.x - padding.x
	var min_y := spawn_rect.position.y + padding.y
	var max_y := spawn_rect.end.y - padding.y

	energy_ball.global_position = Vector2(
		rng.randf_range(min_x, max_x),
		rng.randf_range(min_y, max_y)
	)


func _on_energy_ball_collected() -> void:
	collected_energy_balls += 1
	update_energy_ball_counter()


func update_energy_ball_counter() -> void:
	energy_ball_counter.text = "Energy Balls: %d" % collected_energy_balls
