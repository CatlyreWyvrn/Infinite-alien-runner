extends CharacterBody2D

signal itemCollide

@export var floor = 200
@export var roof = -250

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !global.gameOver:
		position.x += delta * global.speed
		
		if Input.is_action_pressed("up"):
			velocity.y -= 30
			
		if Input.is_action_pressed("down"):
			velocity.y += 15
			
		velocity.y += 9.8
			
		if velocity.x > 500:
			velocity.x = 500
		if velocity.y < -500:
			velocity.y = -500
			
		move_and_slide()
		
		if position.y > floor:
			position.y = floor
			velocity.y = 0
		
		if position.y < roof:
			position.y = roof
			velocity.y = 0
		
