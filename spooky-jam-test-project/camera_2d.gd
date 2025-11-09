extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	offset.x = 400


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.y = 0
