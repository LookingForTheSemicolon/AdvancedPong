extends Control

@onready var window_size_options_button = $TabContainer/Graphics/MarginContainer/Grid/WindowSizeOption
@onready var fullscreen_button = $TabContainer/Graphics/MarginContainer/Grid/FullscreenButton
@onready var player_paddle_option = $TabContainer/Player/MarginContainer/Grid/PlayerPaddleOption
@onready var cpu_paddle_option = $TabContainer/Player/MarginContainer/Grid/CPUPaddleOption

@onready var input_labels_container: VBoxContainer = %InputLabelsContainer
@onready var input_buttons_container: VBoxContainer = %InputButtonsContainer

@export var action_items: Array[String]
var options
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    create_action_remap_items()
    options = OptionsManager.read_options()
    load_defaults()
    load_screen_page()
    load_paddles()
    
func create_action_remap_items() -> void:
    var prev_item = input_buttons_container.get_child(input_buttons_container.get_child_count() -1)
    for index in range(action_items.size()):
        var action = action_items[index]
        var label = Label.new()
        label.text = action
        input_labels_container.add_child(label)
        var button = RemapButton.new()
        button.action = action
        button.action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
        button.toggle_mode = true
        prev_item = button
        input_buttons_container.add_child(button)
            

func load_defaults():
    options = OptionsManager.read_options()
    if not options.has("full_screen"):
       options["full_screen"] = false
    if not options.has("window_width"):
       options["window_width"] = 1920
    if not options.has("window_height"):
       options["window_height"] = 1080
    if not options.has("player_paddle"):
       options["player_paddle"] = OptionsManager.paddleTyps.Standard
    if not options.has("cpu_paddle"):
       options["cpu_paddle"] = OptionsManager.paddleTyps.Standard
    OptionsManager.write_options(options)
    OptionsManager.resize_window()
    
func load_screen_page():
    if options.has("full_screen"):
        fullscreen_button.set_pressed_no_signal(options.full_screen)
        window_size_options_button.clear()
        
    var screen_size = DisplayServer.screen_get_size()
    var index = 0
    for sizeWindow in OptionsManager.window_size_list:
        if sizeWindow.width <= screen_size.x and sizeWindow.height <= screen_size.y:
            window_size_options_button.add_item((str(sizeWindow.width) + " x " + str(sizeWindow.height)))
            if options.has("window_width") and sizeWindow.width == options.window_width and options.has("window_height") and sizeWindow.height == options.window_height:
                window_size_options_button.select(index)
            index += 1
        
func load_paddles():
    var indexPlayer = 0
    var indexCPU = 0
    for paddle in OptionsManager.paddleTyps.values():
        player_paddle_option.add_item(OptionsManager.paddleTyps.find_key(paddle))
        cpu_paddle_option.add_item(OptionsManager.paddleTyps.find_key(paddle))
        if options.has("player_paddle") and paddle == options.player_paddle:
          player_paddle_option.select(indexPlayer) 
        indexPlayer += 1         
        if options.has("cpu_paddle") and paddle == options.cpu_paddle:
          cpu_paddle_option.select(indexCPU) 
        indexCPU += 1
        
func _on_window_size_option_item_selected(index: int) -> void:
    var size = OptionsManager.window_size_list[index]
    options.window_width = size.width
    options.window_height = size.height
    OptionsManager.write_options(options)
    OptionsManager.resize_window()

func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
    options.full_screen = toggled_on
    OptionsManager.write_options(options)
    OptionsManager.set_window_mode()
    OptionsManager.resize_window()

func _on_player_paddle_option_item_selected(index: int) -> void:
    options.player_paddle = index
    OptionsManager.write_options(options)

func _on_cpu_paddle_option_item_selected(index: int) -> void:
    options.cpu_paddle = index
    OptionsManager.write_options(options)
