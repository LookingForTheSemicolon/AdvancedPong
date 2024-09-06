extends Node2D
class_name Movement

@export var paddle: Node2D
@export var ball: CharacterBody2D
@onready var multiplayer_synchronizer: MultiplayerSynchronizer = $"../MultiplayerSynchronizer"

var win_height: int
const PADDLE_SPEED: int = 500

var ball_pos: Vector2
var dist: int 
var move_by: int
var paddleName:StringName = ""
var user_pref = UserPreferences

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    user_pref = UserPreferences.load_or_create()
    win_height = get_viewport_rect().size.y
    paddleName = paddle.name
    multiplayer_synchronizer.set_multiplayer_authority(str(paddle.online_id).to_int())
    

func _process(delta: float) -> void:
    if user_pref.onlineGame:
        if multiplayer_synchronizer.get_multiplayer_authority() != multiplayer.get_unique_id():
            return
            
        if Input.is_action_pressed("up"):
            paddle.position.y -= PADDLE_SPEED * delta
        elif Input.is_action_pressed("down"):
            paddle.position.y += PADDLE_SPEED * delta
        
            paddle.position.y = clamp(paddle.position.y, paddle.p_height / 2, win_height - paddle.p_height / 2)
    else:
        if paddleName.begins_with("Player"):
            if Input.is_action_pressed("up"):
                paddle.position.y -= PADDLE_SPEED * delta
            elif Input.is_action_pressed("down"):
                paddle.position.y += PADDLE_SPEED * delta
            
            paddle.position.y = clamp(paddle.position.y, paddle.p_height / 2, win_height - paddle.p_height / 2)
            
        elif paddleName.begins_with("CPU"):
            if user_pref.game_mode == OptionsManager.gameModes.CPU:
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
                
            elif user_pref.game_mode == OptionsManager.gameModes.PVP:
                if Input.is_action_pressed("ui_up"):
                    paddle.position.y -= PADDLE_SPEED * delta
                elif Input.is_action_pressed("ui_down"):
                    paddle.position.y += PADDLE_SPEED * delta

            paddle.position.y = clamp(paddle.position.y, paddle.p_height / 2, win_height - paddle.p_height / 2)
