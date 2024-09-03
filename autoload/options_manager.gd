extends Node

var window_size_list = [
    { "width": 1920, "height": 1080},
    { "width": 1760, "height": 990},
    { "width": 1600, "height": 900},
    { "width": 1280, "height": 960},
    { "width": 1152, "height": 648},
]
enum paddleTyps {Standard, CShape}

enum gameModes {CPU, PVP}

var user_prefs = UserPreferences

func _ready() -> void:
    user_prefs = UserPreferences.load_or_create()
    
func set_window_mode():
    var window_mode = DisplayServer.WINDOW_MODE_WINDOWED
    if user_prefs.full_screen:
        window_mode = DisplayServer.WINDOW_MODE_FULLSCREEN if user_prefs.full_screen else DisplayServer.WINDOW_MODE_WINDOWED
    DisplayServer.window_set_mode(window_mode)
    
func resize_window():
    if not user_prefs.full_screen:
        var window_size = Vector2(user_prefs.window_size.x, user_prefs.window_size.y)
        var screen_position = DisplayServer.screen_get_position(0) # 0 primary screen
        get_window().size = window_size
        get_window().get_viewport().get_visible_rect().size = window_size
        DisplayServer.window_set_position(Vector2i(screen_position.x, screen_position.y + 25))
