extends Node

const options_path = "user://options.data"

var window_size_list = [
    { "width": 1920, "height": 1080},
    { "width": 1760, "height": 990},
    { "width": 1600, "height": 900},
    { "width": 1280, "height": 960},
    
]

func read_options():
    var options = {}
    print(options_path)
    var file = FileAccess.open(options_path, FileAccess.READ)
    if file:
        options = file.get_var()
        file.close()
    return options

func write_options(options):
    var file = FileAccess.open(options_path, FileAccess.WRITE)
    file.store_var(options)
    file.close()
    
func set_window_mode():
    var window_mode = DisplayServer.WINDOW_MODE_WINDOWED
    var options = read_options()
    if options.has("full_screen"):
        window_mode = DisplayServer.WINDOW_MODE_FULLSCREEN if options.full_screen else DisplayServer.WINDOW_MODE_WINDOWED
    DisplayServer.window_set_mode(window_mode)
    write_options(options)
    
func  resize_window():
    var options = read_options()
    if not options.has("full_screen") or not options.full_screen:
        var window_size = Vector2(options.window_width, options.window_height)
        var screen_size = DisplayServer.screen_get_size()
        get_window().size = window_size
        DisplayServer.window_set_position(Vector2i(window_size.x, 100))
        
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
