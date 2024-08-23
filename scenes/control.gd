extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func _on_start_button_pressed() -> void:
    var start_scene = preload("res://scenes/Main.tscn").instantiate()
    get_tree().root.add_child(start_scene)


func _on_options_button_pressed() -> void:
    pass # Replace with function body.


func _on_exit_button_pressed() -> void:
    pass # Replace with function body.
