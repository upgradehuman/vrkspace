extends Spatial

onready var Player = load("res://scenes/user.tscn")

func _ready():
	var interface = ARVRServer.find_interface("OpenVR")
	if interface:
		if interface.initialize():
			# turn the main viewport into an ARVR viewport:
			get_viewport().arvr = true

			# turn off v-sync
			OS.vsync_enabled = false

			# put our physics in sync with our expected frame rate:
			Engine.iterations_per_second= 90

puppet func spawn_player(spawn_pos, id):
	var player = Player.instance()
	
	player.transform.origin = Vector3(spawn_pos.x/100, 0, spawn_pos.y/100)
	player.name = String(id) # Important
	player.set_network_master(id) # Important
	
	$Players.add_child(player)


puppet func remove_player(id):
	$Players.get_node(String(id)).queue_free()
