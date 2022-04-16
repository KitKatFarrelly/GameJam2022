extends RigidBody2D


# Declare member variables here. Examples:
export var bulletspeed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var velocity = Vector2.ZERO # Bullet movement vector

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	velocity.y = -bulletspeed
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
