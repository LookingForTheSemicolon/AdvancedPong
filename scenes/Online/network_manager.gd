class_name NetworkManager extends Control

@onready var host_button: Button = $Local/Buttons/HostButton
@onready var join_button: Button = $Local/Buttons/JoinButton
@onready var start_server: Button = $Local/Buttons/StartServer
@onready var ip_input: TextEdit = $Local/IP/IPInput

const MAX_PLAYERS = 2
@export var address = "127.0.0.1"
@export var port = 8080

var peer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    host_button.pressed.connect(_on_host_button_pressed)
    join_button.pressed.connect(_on_join_button_pressed)

    multiplayer.peer_connected.connect(on_peer_connected)
    multiplayer.peer_connected.connect(on_peer_disconnected)
    multiplayer.connected_to_server.connect(on_connect_to_server)
    multiplayer.connection_failed.connect(on_connection_failed)

func on_peer_connected(id:int) -> void:
    print("Player connected: " + str(id))
    
func on_peer_disconnected(id:int) -> void:
    print("Player disconnected: " + str(id))
    
func on_connect_to_server() -> void:
    send_player_info.rpc_id(1, ip_input.text, multiplayer.get_unique_id())
    
func on_connection_failed() -> void:
    print("Connection failed")
    
func _on_host_button_pressed() -> void:
    peer = ENetMultiplayerPeer.new()
    var error = peer.create_server(port, MAX_PLAYERS)
    if error != OK:
        print("cannot host:" + error)
        return
    
    peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
    multiplayer.set_multiplayer_peer(peer)
    print("waiting for other player")
    send_player_info(ip_input.text, multiplayer.get_unique_id())

func _on_join_button_pressed() -> void:
    peer = ENetMultiplayerPeer.new()
    peer.create_client(address, port)
    peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
    multiplayer.set_multiplayer_peer(peer)


func _on_start_server_pressed() -> void:
    start_game.rpc()
    
@rpc("any_peer", "call_local")
func start_game():
    var scene = load("res://scenes/game.tscn").instantiate()
    get_tree().root.add_child(scene)
    hide()
    
@rpc("any_peer")
func send_player_info(nameOfPlayer, id):
    if !GameManager.Players.has(id):
        GameManager.Players[id] = {
            "name": name,
            "id": id
        }
        
    if multiplayer.is_server():
        for player in GameManager.Players:
            send_player_info.rpc(GameManager.Players[player].name, player)
