extends StaticBody2D
class_name PlayerC

var inner_height: int
var win_height: int
var p_height: int

signal topCol
signal sideCol
signal bottomCol
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    win_height = get_viewport_rect().size.y
    p_height = 120
    position.x = 50
    position.y = get_viewport().size.y / 2
    
func get_class_name():
    return "PlayerC"

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
