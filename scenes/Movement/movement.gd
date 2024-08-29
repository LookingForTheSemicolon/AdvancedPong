extends Node2D
class_name Movement

@export var paddle: StaticBody2D
@export var ball: CharacterBody2D
var win_height: int
const PADDLE_SPEED: int = 500

var ball_pos: Vector2
var dist: int 
var move_by: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    win_height = get_viewport_rect().size.y

func _process(delta: float) -> void:
    if paddle.get_class_name() != "CPU":
        if Input.is_action_pressed("up"):
            paddle.position.y -= PADDLE_SPEED * delta
        elif Input.is_action_pressed("down"):
            paddle.position.y += PADDLE_SPEED * delta
        
        paddle.position.y = clamp(paddle.position.y, paddle.p_height / 2, win_height - paddle.p_height / 2)
        
    elif paddle.get_class_name() == "CPU":
        #move paddle towards ball
        ball_pos = ball.position
        dist = paddle.position.y - ball_pos.y
        if abs(dist) > PADDLE_SPEED * delta:
            #move above or below
            move_by = PADDLE_SPEED * delta * (dist /abs(dist))
        else:
            move_by = dist 
            
        paddle.position.y -= move_by
        paddle.position.y = clamp(paddle.position.y, paddle.p_height / 2, win_height - paddle.p_height / 2)
