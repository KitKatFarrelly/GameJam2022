extends Node


# Declare member variables here. Examples:
export(PackedScene) var bullet_inst
export(PackedScene) var popcorn_spawn
export(PackedScene) var enemyBul_inst

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()

func new_game():
	$Player.start($StartPosition.position)
	$SpawnTimer.start()
	$Stage1.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.fireFlag == 1 && $Autofire.is_stopped():
		$Autofire.start()
	for pop in get_tree().get_nodes_in_group("enemies"):
		if pop.canFire == 1:
			pop.canFire = 0
			newEnemyBullet(0,pop)

func _on_Autofire_timeout():
	var newBullet = bullet_inst.instance()
	newBullet.position = $Player.position
	add_child(newBullet)

func newEnemyBullet(type,enemyinst):
	var newEnemyBullet = enemyBul_inst.instance()
	var aimVec = $Player.position - enemyinst.position
	newEnemyBullet.setDir(aimVec.normalized())
	newEnemyBullet.position = enemyinst.position
	add_child(newEnemyBullet)

func _on_SpawnTimer_timeout():
	var newPop = popcorn_spawn.instance()
	var pop_location = get_node("SpawnRandom/SpawnRandLoc")
	pop_location.offset = randi()
	newPop.position = pop_location.position
	newPop.add_to_group("enemies")
	add_child(newPop)


func _on_Player_respawn():
	$Player.start($StartPosition.position)
