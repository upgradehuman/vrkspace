extends Control

onready var status = get_node("ColorRect/VBox/Status")


func _ready():
	gamestate.connect("connection_failed", self, "_on_connection_failed")
	gamestate.connect("connection_succeeded", self, "_on_connection_success")
	gamestate.connect("server_disconnected", self, "_on_server_disconnect")
	gamestate.connect("players_updated", self, "update_players_list")

func _on_JoinButton_pressed():
	$ColorRect/VBox/JoinButton.disabled = true
	status.text = "Connecting..."
	status.modulate = Color.blue
	gamestate.ip = $ColorRect/VBox/Hostname.text
	gamestate.my_name = $ColorRect/VBox/Nametag.text
	gamestate.connect_to_server()

func _on_connection_success():
	status.text = "Connected"
	status.modulate = Color.green
	gamestate.pre_start_game()

func _on_connection_failed():
	$ColorRect/VBox/JoinButton.disabled = true
	
	status.text = "Connection Failed, trying again"
	status.modulate = Color.red


func _on_server_disconnect():
	$ColorRect/VBox/JoinButton.disabled = true
	
	status.text = "Server Disconnected, trying to connect..."
	status.modulate = Color.red
