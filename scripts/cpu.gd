extends StaticBody2D
class_name CPU


var p_height: int

func get_class_name():
    return "CPU"
        
func _ready() -> void:
    position.x = get_viewport().size.x -50
    position.y = get_viewport().size.y / 2
    p_height = get_node("Sprite2D").texture.get_size().y
    
