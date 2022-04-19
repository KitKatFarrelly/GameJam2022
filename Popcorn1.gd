extends Area2D


# Declare member variables here. Examples:
export var enemyspeed = 50 # How fast the enemy will move (pixels/sec).
var screen_size # Size of the game window.
var firetype = 0 # what type of pattern will the enemy shoot
var eventpattern = 0 # what movements and shooting will the enemy do
var patternstate = 0 # where in the pattern is the enemy currently at
var canFire = 0 # determines whether the enemy can fire or not
var angle = 0.0 # determines angle in radians for the enemy to travel in
var moving = 1 # determines whether enemy is stopped or not
var curvespeed = 1 # determines radians per tick that the angle the enemy is moving at changes when turning
var shotgun = 2 # determines how many bullets fired per round
var angoff = (PI / 2) / 45 # angle between bullets in radians
var distoff = 0 # distance in pixels each bullet is normal to the direction of bullet fire
var nextang = 0 # next angle this enemy wants to shoot at
var shottype = 0 # enemy shot type
var health = 200 # enemy health

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$EventTimer.wait_time == 3
	$EventTimer.start()
	$FireTimer.start()
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(position.x < 320 or position.x > 704):
		hide()
		queue_free()
	if canFire == 0:
		canFire = -1
		$FireTimer.start()
	match patternstate:
		0:
			angle = 3 * PI / 2
		1:
			angle += curvespeed * delta
		2:
			moving = 0
		_:
			moving = 1
	$Sprite.rotation = -cos(angle)
	position.x += cos(angle) * enemyspeed * delta * moving
	position.y += sin(angle) * -enemyspeed * delta * moving # negative bc up is negative.

func _on_EventTimer_timeout():
	match patternstate:
		0:
			$EventTimer.wait_time == 30
			$EventTimer.start()
		1:
			$EventTimer.wait_time == 30
			$EventTimer.start()
		2:
			$EventTimer.wait_time == 1
			$EventTimer.start()
		_:
			pass
	patternstate += 1


func _on_FireTimer_timeout():
	canFire = 1

func _on_Popcorn1_body_entered(body):
	if("Playerbullet" in body.name):
		health = health - body.damage
	if health < 0:
		hide()
		queue_free()


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	hide()
	queue_free()
