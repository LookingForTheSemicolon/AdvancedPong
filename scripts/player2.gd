extends CharacterBody2D 
var win_height: int
var p_height: int
var p_width: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    win_height = get_viewport_rect().size.y
    p_height = $CollisionSide/ColorRect.get_size().y
    p_width = $CollisionSide/ColorRect.get_size().x
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if Input.is_action_pressed("up"):
        position.y -= get_parent().PADDLE_SPEED * delta
    elif Input.is_action_pressed("down"):
        position.y += get_parent().PADDLE_SPEED * delta
    
        
    position.y = clamp(position.y, p_height / 2 + p_width, win_height - p_height / 2 - p_width)
