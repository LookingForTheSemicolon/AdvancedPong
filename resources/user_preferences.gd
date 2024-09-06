class_name UserPreferences extends Resource

@export var game_mode:int = 0
@export var player_paddle: int = 0
@export var cpu_player2_paddle: int = 0
@export var action_events: Dictionary = {}
@export var full_screen: bool = false
@export var window_size: Vector2 = Vector2(1920, 1080)
@export var onlineGame: bool = false

func save() -> void:
    ResourceSaver.save(self, "user://user_prefs.tres")
    
static func load_or_create() -> UserPreferences:    
    var res: UserPreferences = load("user://user_prefs.tres")
    if !res:
        res = UserPreferences.new()
    return res
