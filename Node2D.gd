extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 0 # How fast the screen will move (pixels/sec).
var screen_size # Size of the game window.
var fireFlag = 0
signal respawn

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

func start():
	show()
	speed = 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y < 1000:
		position.y += speed * delta
