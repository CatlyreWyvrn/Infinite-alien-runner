extends Node

@export var speed = 150
@export var topSpeed = 400
@export var score : int
@export var oxygen = 100
var gameOver : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	speed = 150
	oxygen = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
