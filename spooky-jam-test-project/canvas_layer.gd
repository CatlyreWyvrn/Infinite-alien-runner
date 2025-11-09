extends CanvasLayer

signal resetScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GameOverLabel.visible = false
	$GameRestartButton.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$ScoreLabel.text = str("Score: ", global.score)
	$OxygenLabel.text = str(global.oxygen, "%")
	var pos : float = 1 - (global.oxygen / 100.0)
	$OxygenMask/OxygenBar.position.x = -pos

func _on_game_restart_button_pressed() -> void:
	resetScene.emit() # Replace with function body.
