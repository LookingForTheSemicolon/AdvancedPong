extends Node2D
class_name PaddleC

var p_height: int
@export_enum("Player", "CPU") var paddleTyp
enum paddleName {Player, CPU}

func get_class_name():
    if not paddleTyp == null:
        return paddleName.find_key(paddleTyp)
    
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    if not paddleTyp == null:
        p_height = get_polygon_height()
        var width = get_viewport().size
        print(width)
        if paddleTyp == paddleName.Player:
            position.x = 50
            position.y = get_viewport().size.y / 2
        else:
            position.x = get_viewport().size.x -50
            position.y = get_viewport().size.y / 2
            rotation_degrees = 180
        
func get_polygon_height() -> float:
    var vertices = $Polygon2D.polygon
    if vertices.size() == 0:
        return 0.0  # Return 0 if there are no vertices

    var min_y = vertices[0].y
    var max_y = vertices[0].y

    # Iterate through vertices to find min and max Y values
    for vertex in vertices:
        if vertex.y < min_y:
            min_y = vertex.y
        if vertex.y > max_y:
            max_y = vertex.y

    # Calculate height
    return max_y - min_y
