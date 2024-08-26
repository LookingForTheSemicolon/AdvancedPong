extends Control

@onready var window_size_options_button = $TabContainer/Graphics/MarginContainer/VBoxContainer/WindowSizeOption
@onready var fullscreen_button = $TabContainer/Graphics/MarginContainer/VBoxContainer/FullscreenButton

var options
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    options = OptionsManager.read_options()
    if(options.has("full_screen")):
        fullscreen_button.set_pressed_no_signal(options.full_screen)
    window_size_options_button.clear()
    var screen_size = DisplayServer.screen_get_size()
    var index = 0
    for size in OptionsManager.window_size_list:
        if size.width <= screen_size.x and size.height <= screen_size.y:
            window_size_options_button.add_item((str(size.width) + " x " + str(size.height)))
            if options.has("window_width") and size.width == options.window_width and options.has("window_height") and size.height == options.window_height:
                window_size_options_button.select(index)
            index += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


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
