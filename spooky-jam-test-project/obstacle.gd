extends Area2D

@onready var animated = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	global.oxygen = max(global.oxygen - self.get_meta("OxygenLost"), 0)
	self.queue_free()
