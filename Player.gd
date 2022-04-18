extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 150 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var fireFlag = 0
signal respawn

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	fireFlag = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$AnimatedSprite.set_frame(1)
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$AnimatedSprite.set_frame(2)
	if(velocity.x == 0):
		$AnimatedSprite.set_frame(0)
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("fire_main"):
		fireFlag = 1;
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 336, 688)
	position.y = clamp(position.y, 16, screen_size.y-16)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_Player_body_entered(body):
	if("EnemyBul1" in body.name):
		hide()
		emit_signal("respawn")
