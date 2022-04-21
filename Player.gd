extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 300 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var fireFlag = 0
var invuln = false
var canFire = false
var invis = true
var optioncount = 1
signal respawn

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	canFire = false
	invis = true
	invuln = true
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
	if(Input.is_action_pressed("fire_main") and canFire):
		fireFlag = 1;
	if(Input.is_action_pressed("fire_bomb") and not invis and optioncount > 0):
		invis = true
		$AnimatedSprite.set_animation("Invis")
		$Invistimer.start()
	if(Input.is_action_pressed("fire_special") and optioncount > 0):
		pass # implement flare code
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 336, 688)
	position.y = clamp(position.y, 16, screen_size.y-16)

func start(pos):
	position = pos
	$AnimatedSprite.set_animation("Ship")
	show()
	$CollisionShape2D.disabled = false
	$"Respawn Timer".stop()
	$Invistimer.stop()
	invuln = true
	canFire = true
	invis = false
	$iFrames.start()


func _on_Player_body_entered(body):
	if("EnemyBul1" in body.name and not invuln):
		hide()
		$"Respawn Timer".start()
		invuln = true
		canFire = false

func _on_Respawn_Timer_timeout():
	emit_signal("respawn")


func _on_iFrames_timeout():
	invuln = false

func _on_Invistimer_timeout():
	invis = false
	$AnimatedSprite.set_animation("Ship")
