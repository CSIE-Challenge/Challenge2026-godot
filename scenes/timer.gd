extends Timer

var game_time: int = 0

func _ready() -> void:
	timeout.connect(_on_timeout)

func _on_timeout() -> void:
	game_time += 1
	
	print("current time: ", game_time, " seconds")
