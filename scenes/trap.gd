extends CharacterBody2D

@export var hit_damage := 10.0

var speed: float = 400.0

func _ready() -> void:
	var random_dir = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	velocity = random_dir * speed

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var wall_normal = collision.get_normal()
		velocity = velocity.bounce(wall_normal)
		
		var collider = collision.get_collider()
		if collider.has_method("damage"):
			collider.damage(hit_damage)
