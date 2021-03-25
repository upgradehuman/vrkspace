extends Spatial

onready var Player = load("res://scenes/avatar.tscn")


puppetsync func spawn_player(spawn_pos, id):
	var player = Player.instance()
	
	player.transform.origin = Vector3(spawn_pos.x/100, 0, spawn_pos.y/100)
	player.name = String(id) # Important
	player.set_network_master(id) # Important
	
	$Players.add_child(player)


puppetsync func remove_player(id):
	$Players.get_node(String(id)).queue_free()
