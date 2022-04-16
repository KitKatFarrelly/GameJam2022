extends Node


# Declare member variables here. Examples:
export(PackedScene) var bullet_inst


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()

func new_game():
	$Player.start($StartPosition.position)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.fireFlag == 1 && $Autofire.is_stopped():
		$Autofire.start()
func _on_Autofire_timeout():
	var newBullet = bullet_inst.instance()
	newBullet.position = $Player.position
	add_child(newBullet)

