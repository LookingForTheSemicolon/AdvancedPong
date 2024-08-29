extends StaticBody2D
class_name Player

var win_height: int
var p_height: int

func get_class_name():
    return "Player"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    p_height = get_node("Sprite2D").texture.get_size().y
    position.x = 50
    position.y = get_viewport().size.y / 2
