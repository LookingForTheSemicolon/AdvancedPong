extends Button
class_name RemapButton

@export var action: String

func _init() -> void:
    toggle_mode = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    set_process_unhandled_input(false)
    update_key_text()

func _toggled(button_pressed: bool) -> void:
    print(button_pressed)
    set_process_unhandled_input(button_pressed)
    if button_pressed:
        text = "..."
        release_focus()
    else:
        update_key_text()
        grab_focus()

func _unhandled_input(event: InputEvent) -> void:
    print(event)
    if event.pressed:
        InputMap.action_erase_events(action)
        InputMap.action_add_event(action, event)
        button_pressed = false

func update_key_text():
    print(InputMap.action_get_events(action)[0].as_text())
    text = "%s" % InputMap.action_get_events(action)[0].as_text()
