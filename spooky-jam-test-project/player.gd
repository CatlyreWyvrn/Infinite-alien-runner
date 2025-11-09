extends Area2D

signal itemCollide
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !global.gameOver:
		position.x += (global.speed * delta)

func _on_body_entered(body: Node2D) -> void:
	body.set_deferred("CollisionShape2D", false)
	if body.get_groups().has("Collectable"):
		global.oxygen = min(global.oxygen + body.get_meta("OxygenGiven"), 100)
	if body.get_groups().has("obstacle"):
		global.oxygen = max(global.oxygen - body.get_meta("OxygenLost"), 0)
	body.queue_free()
