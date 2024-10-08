class_name RemapButton
extends Button

@export var action: String
signal action_remapped(action: String, event: InputEvent)

func _init() -> void:
    toggle_mode = true
    theme = preload("res://theme/default_theme.tres")
    theme_type_variation = "RemapButton"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    set_process_unhandled_input(false)
    update_key_text()

func _toggled(_button_pressed: bool) -> void:
    set_process_unhandled_input(_button_pressed)
    if _button_pressed:
        text = "..."
        release_focus()
    else:
        update_key_text()
        grab_focus()

func _unhandled_input(event: InputEvent) -> void:
    if event.pressed:
        InputMap.action_erase_events(action)
        InputMap.action_add_event(action, event)
        button_pressed = false
        action_remapped.emit(action, event)

func update_key_text():
    text = "%s" % InputMap.action_get_events(action)[0].as_text()
