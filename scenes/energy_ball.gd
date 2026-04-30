extends Area2D

signal collected

const LIFETIME_SECONDS := 5.0


func _ready() -> void:
	body_entered.connect(_on_body_entered)

	var lifetime_timer := Timer.new()
	lifetime_timer.wait_time = LIFETIME_SECONDS
	lifetime_timer.one_shot = true
	lifetime_timer.timeout.connect(queue_free)
	add_child(lifetime_timer)
	lifetime_timer.start()


func _on_body_entered(body: Node) -> void:
	if body.name != "Player":
		return

	collected.emit()
	queue_free()
