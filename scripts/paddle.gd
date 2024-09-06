extends Node2D
class_name Paddle

var p_height: int
@export_enum("Player", "CPU") var paddleTyp
enum paddleName {Player, CPU}
var online_id: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    if not paddleTyp == null:
        p_height = get_node("Sprite2D").texture.get_size().y
        
