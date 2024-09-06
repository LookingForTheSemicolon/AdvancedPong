class_name Settings extends Control

@onready var window_size_options_button = $TabContainer/Graphics/MarginContainer/Grid/WindowSizeOption
@onready var fullscreen_button = $TabContainer/Graphics/MarginContainer/Grid/FullscreenButton
@onready var player_paddle_option = $TabContainer/Player/MarginContainer/Grid/PlayerPaddleOption
@onready var cpu_paddle_option = $TabContainer/Player/MarginContainer/Grid/CPUPaddleOption

@onready var input_labels_container: VBoxContainer = %InputLabelsContainer
@onready var input_buttons_container: VBoxContainer = %InputButtonsContainer
@onready var mode_options: OptionButton = %ModeOptions

@export var action_items: Array[String]

var user_prefs: UserPreferences

func _ready() -> void:
    user_prefs = UserPreferences.load_or_create()
    if mode_options:
        mode_options.selected = user_prefs.game_mode
    if player_paddle_option:
        player_paddle_option.selected = user_prefs.player_paddle
    if cpu_paddle_option:
        cpu_paddle_option.selected = user_prefs.cpu_player2_paddle
    
    create_action_remap_items()
    load_game_modes()
    load_screen_page()
    load_paddles()
    
    
func create_action_remap_items() -> void:
    var prev_item = input_buttons_container.get_child(input_buttons_container.get_child_count() -1)
    for index in range(action_items.size()):
        var action = action_items[index]
        var label = Label.new()
        label.text = action
        label.theme = preload("res://theme/default_theme.tres")
        label.theme_type_variation = "RemapLabel"
        input_labels_container.add_child(label)
        var button = RemapButton.new()
        button.action = action
        button.action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
        button.toggle_mode = true
        prev_item = button
        if user_prefs:
            if user_prefs.action_events.has(action):
                var event = user_prefs.action_events[action]
                InputMap.action_erase_events(action)
                InputMap.action_add_event(action, event)
            button.action_remapped.connect(_on_action_remapped)
        input_buttons_container.add_child(button)

func _on_action_remapped(action: String, event: InputEvent) -> void:
    if user_prefs:
        user_prefs.action_events[action] = event
        user_prefs.save()

func load_screen_page():
    if user_prefs.full_screen:
        fullscreen_button.set_pressed_no_signal(user_prefs.full_screen)
        window_size_options_button.clear()
        
    var screen_size = DisplayServer.screen_get_size()
    var index = 0
    for sizeWindow in OptionsManager.window_size_list:
        if sizeWindow.width <= screen_size.x and sizeWindow.height <= screen_size.y:
            window_size_options_button.add_item((str(sizeWindow.width) + " x " + str(sizeWindow.height)))
            if user_prefs.window_size.x and sizeWindow.width == user_prefs.window_size.x and user_prefs.window_size.y and sizeWindow.height == user_prefs.window_size.y:
                window_size_options_button.select(index)
            index += 1
        
func load_paddles():
    var indexPlayer = 0
    var indexCPU = 0
    for paddle in OptionsManager.paddleTyps.values():
        player_paddle_option.add_item(OptionsManager.paddleTyps.find_key(paddle))
        cpu_paddle_option.add_item(OptionsManager.paddleTyps.find_key(paddle))
        if user_prefs.player_paddle and paddle == user_prefs.player_paddle:
          player_paddle_option.select(indexPlayer) 
        indexPlayer += 1         
        if user_prefs.cpu_player2_paddle and paddle == user_prefs.cpu_player2_paddle:
          cpu_paddle_option.select(indexCPU) 
        indexCPU += 1

func load_game_modes() -> void:
    var index = 0
    for mode in OptionsManager.gameModes.values():
        mode_options.add_item(OptionsManager.gameModes.find_key(mode))
        if user_prefs.game_mode and mode == user_prefs.game_mode:
            mode_options.select(index)
        index += 1


func _on_window_size_option_item_selected(index: int) -> void:
    var size = OptionsManager.window_size_list[index]
    user_prefs.window_size.x = size.width
    user_prefs.window_size.y = size.height
    OptionsManager.resize_window()
    user_prefs.save()

func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
    user_prefs.full_screen = toggled_on
    OptionsManager.set_window_mode()
    OptionsManager.resize_window()
    user_prefs.save()

func _on_player_paddle_option_item_selected(index: int) -> void:
    user_prefs.player_paddle = index
    user_prefs.save()

func _on_cpu_paddle_option_item_selected(index: int) -> void:
    user_prefs.cpu_player2_paddle = index
    user_prefs.save()


func _on_mode_options_item_selected(index: int) -> void:
    user_prefs.game_mode = index
    user_prefs.save()
