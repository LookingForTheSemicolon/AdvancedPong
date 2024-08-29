extends Control

@onready var start_button = $VBoxContainer/StartButton as Button
@onready var options_button = $VBoxContainer/OptionsButton as Button
@onready var exit_button = $VBoxContainer/ExitButton as Button

@onready var start_level = preload("res://scenes/game.tscn") as PackedScene

@onready var options_menu = $Options as Options_Menu
@onready var containerVB = $VBoxContainer as VBoxContainer
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
    handle_connection_singals()
    OptionsManager.set_window_mode()
    start_button.grab_focus()
    
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass


func _on_start_button_pressed() -> void:
    get_tree().change_scene_to_packed(start_level)

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
    start_button.button_down.connect(_on_start_button_pressed)
    options_button.button_down.connect(_on_options_button_pressed)
    exit_button.button_down.connect(_on_exit_button_pressed)
    options_menu.exit_options_menu.connect(_on_options_exit_option_menu)
