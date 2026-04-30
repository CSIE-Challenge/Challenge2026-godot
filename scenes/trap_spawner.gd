extends Node2D

@export var trap_scene: PackedScene # Drag your trap.tscn here in the Inspector

func _ready() -> void:
    var timer = Timer.new()
    add_child(timer)
    timer.autostart = true
    timer.one_shot = false
    timer.timeout.connect(_on_timer_timeout)
    
    # Spawn the first one immediately
    _on_timer_timeout()

func _on_timer_timeout() -> void:
    if trap_scene:
        var new_trap = trap_scene.instantiate()

        new_trap.global_position = Vector2(1000,530)
        get_parent().add_child.call_deferred(new_trap)