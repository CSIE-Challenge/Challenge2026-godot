extends Node2D

@export var trap_scene: PackedScene # Drag your trap.tscn here in the Inspector
@export var spawn_interval: float = 1.5 # Seconds between spawns

func _ready() -> void:
    var timer = Timer.new()
    add_child(timer)
    timer.wait_time = spawn_interval
    timer.autostart = true
    timer.one_shot = false
    timer.timeout.connect(_on_timer_timeout)
    
    # Spawn the first one immediately
    _on_timer_timeout()

func _on_timer_timeout() -> void:
    if trap_scene:
        var new_trap = trap_scene.instantiate()

        # Define the boundary based on your provided images
        var x_min = 524.5
        var x_max = 1463.5
        var y_min = 75.5
        var y_max = 981.5

        # Pick a random spot inside those sticks
        var spawn_pos = Vector2(
        randf_range(x_min, x_max),
        randf_range(y_min, y_max)
        )

        var side = randi() % 4 # Pick a number 0, 1, 2, or 3
        
        match side:
            0: # Left edge: X is fixed, Y is random
                spawn_pos.x = x_min
            1: # Right edge: X is fixed, Y is random
                spawn_pos.x = x_max
            2: # Top edge: Y is fixed, X is random
                spawn_pos.y = y_min
            3: # Bottom edge: Y is fixed, X is random
                spawn_pos.y = y_max

        new_trap.global_position = spawn_pos
        get_parent().add_child(new_trap)