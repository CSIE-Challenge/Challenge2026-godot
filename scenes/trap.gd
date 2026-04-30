extends CharacterBody2D

var speed: float = 400.0
const WALL_HIT_LIMIT: int = 3
var collision_count: int = 0

func _ready() -> void:
	var random_dir = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	velocity = random_dir * speed

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		collision_count += 1
		if (collision_count >= WALL_HIT_LIMIT):
			queue_free()
		var wall_normal = collision.get_normal()
		velocity = velocity.bounce(wall_normal)

# added from feat/trap_spawner, use queue_free() to remove traps
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Deletes the trap once it leaves the screen