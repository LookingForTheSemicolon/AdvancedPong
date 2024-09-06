extends CanvasLayer

@onready var start_local_button = $Local/StartLocalButton as Button
@onready var options_button = $Local/OptionsButton as Button
@onready var exit_button = $Local/ExitButton as Button
@onready var start_online_button: Button = $Local/StartOnlineButton

@onready var start_level = preload("res://scenes/game.tscn") as PackedScene
@onready var networt_manager = preload("res://scenes/Online/NetworkManager.tscn")
@onready var options_menu = $Options as Options_Menu
@onready var containerVB = $Local as VBoxContainer

var user_prefs
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
    user_prefs = UserPreferences.load_or_create()
    handle_connection_singals()
    OptionsManager.set_window_mode()
    start_local_button.grab_focus()
    
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass


func _on_start_local_button_pressed() -> void:
    user_prefs.onlineGame = false
    user_prefs.save()
    get_tree().change_scene_to_packed(start_level)
    
func _on_start_online_button_pressed() -> void:
    user_prefs.onlineGame = true
    user_prefs.save()
    get_tree().change_scene_to_packed(networt_manager)
    
func _on_options_button_pressed() -> void:
    containerVB.visible = false
    options_menu.set_process(true)
    options_menu.visible = true
    
func _on_exit_button_pressed() -> void:
    get_tree().quit()


func _on_options_exit_option_menu() -> void:
    containerVB.visible = true
    options_menu.visible = false   
    options_button.grab_focus()
    
func handle_connection_singals() -> void:
    start_local_button.button_down.connect(_on_start_local_button_pressed)
    start_online_button.button_down.connect(_on_start_online_button_pressed)
    options_button.button_down.connect(_on_options_button_pressed)
    exit_button.button_down.connect(_on_exit_button_pressed)
    options_menu.exit_options_menu.connect(_on_options_exit_option_menu)
    
    
