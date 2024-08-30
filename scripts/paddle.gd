extends Node2D
class_name Paddle

var p_height: int
@export_enum("Player", "CPU") var paddleTyp
enum paddleName {Player, CPU}

func get_class_name():
    if not paddleTyp == null:
        return paddleName.find_key(paddleTyp)
    
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    if not paddleTyp == null:
        p_height = get_node("Sprite2D").texture.get_size().y
        if paddleTyp == paddleName.Player:
            position.x = 50
            position.y = get_viewport().size.y / 2
        else:
            position.x = get_viewport().size.x -50
            position.y = get_viewport().size.y / 2
        
