extends Node

@export var floorTile_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_2_collide(body) -> void:
	var floorTile = floorTile_scene.instantiate()
	var tSpr : Sprite2D = floorTile.get_node("Sprite2D")
	var rectSize : Vector2 = tSpr.scale
	var newPos = Vector2(body.global_position.x + rectSize.x, body.global_position.y)
	floorTile.position = newPos
	call_deferred("add_child", floorTile)
