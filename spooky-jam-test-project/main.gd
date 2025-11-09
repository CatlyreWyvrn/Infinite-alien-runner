extends Node

@export var floorTile_scene: PackedScene
@export var obstacle_scene : PackedScene
@export var oxygenTank_scene : PackedScene
@onready var timer : Timer = $ScoreTimer
@onready var oxyTimer : Timer = $OxygenTimer
var lastY = 1
var obstacleTime = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ObstacleTimer.wait_time = randf_range(obstacleTime, obstacleTime + 2)
	$OxygenTankSpawnTimer.wait_time = randf_range(11.0, 20.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	global.speed = 150 + (global.score * 2)
	
	if global.score > 200:
		$ObstacleTimer.wait_time = randf_range(0.5, 1)
	else:
		$ObstacleTimer.wait_time = randf_range(obstacleTime - (global.score/100), obstacleTime + 2 - (global.score/50))
	
	if global.gameOver:
		$ScoreTimer.stop()
		$OxygenTimer.stop()
		$HUD/GameOverLabel.text = str("GAME OVER\nScore: ", global.score)
		$HUD/GameOverLabel.visible = true
		await get_tree().create_timer(1.0).timeout
		$HUD/GameRestartButton.visible = true
		$HUD/GameRestartButton.disabled = false

func _on_area_2d_2_collide(body) -> void:
	var floorTile = floorTile_scene.instantiate()
	var tSpr : Sprite2D = floorTile.get_node("Sprite2D")
	var rectSize : Vector2 = tSpr.scale
	var newPos = Vector2(body.global_position.x + rectSize.x, body.global_position.y)
	floorTile.position = newPos
	call_deferred("add_child", floorTile)

func _on_timer_timeout() -> void:
	global.score += 1
	if global.speed < global.topSpeed:
		global.speed += 1

func _on_oxygen_timer_timeout() -> void:
	global.oxygen -= 1
	if global.oxygen <= 0:
		global.gameOver = true


func _on_hud_reset_scene() -> void:
	get_tree().reload_current_scene()
	global._ready()
	global.gameOver = false


func _on_obstacle_timer_timeout() -> void:
	var obstacleIns = obstacle_scene.instantiate()
	if lastY < 0:
		obstacleIns.position = Vector2($TileSpawnCollider.global_position.x, randf_range(1, 250))
	if lastY > 0:
		obstacleIns.position = Vector2($TileSpawnCollider.global_position.x, randf_range(-250, -1))
	lastY = obstacleIns.position.y
	$ObstacleTimer.wait_time = randf_range(2.0, 3.8)
	add_child(obstacleIns)


func _on_oxygen_tank_spawn_timer_timeout() -> void:
	var oxygenTankInc = oxygenTank_scene.instantiate()
	oxygenTankInc.position = Vector2($TileSpawnCollider.global_position.x, randf_range(-250, 250))
	$OxygenTankSpawnTimer.wait_time = randf_range(11.0, 20.0)
	add_child(oxygenTankInc)
