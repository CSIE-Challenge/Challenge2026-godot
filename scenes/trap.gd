extends CharacterBody2D

var speed: float = 400.0
@export var homing_strength:float = 500.0
var player:CharacterBody2D

func _ready() -> void:
	var random_dir = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	velocity = random_dir * speed
	var players = get_tree().get_nodes_in_group("player")
	if players.size()>0:
		player=players[0]

func _physics_process(delta: float) -> void:
	if velocity.dot(player.position-position)>0: 
		var turn=velocity.cross(player.position-position)
		if turn > 0:
			velocity+=velocity.rotated(PI/2).normalized()*homing_strength*delta
		else:
			velocity+=velocity.rotated(-PI/2).normalized()*homing_strength*delta
		
		velocity=velocity.normalized()*speed
		
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var wall_normal = collision.get_normal()
		velocity = velocity.bounce(wall_normal)
