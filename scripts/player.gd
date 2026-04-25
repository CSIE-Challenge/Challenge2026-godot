extends CharacterBody2D

const SPEED = 300.0

@onready var anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction:
		velocity = direction * SPEED
		
		var anim_name = "walk"
		
		if direction.y < 0:
			anim_name += "_up"
		elif direction.y > 0:
			anim_name += "_down"
			
		if direction.x < 0:
			anim_name += "_left"
		elif direction.x > 0:
			anim_name += "_right"
			
		anim.play(anim_name)
		
	else:
		velocity = Vector2.ZERO
		anim.stop()

	move_and_slide()
