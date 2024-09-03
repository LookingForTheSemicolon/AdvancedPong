extends CanvasLayer

var score := [0,0] #0:Player, 1:CPI

const PADDLE_SPEED: int = 500
@onready var standardPaddle = preload("res://scenes/PlayerPaddles/Default/paddle.tscn")
@onready var cPaddle = preload("res://scenes/PlayerPaddles/CShape/paddleC.tscn")

var user_prefs: UserPreferences
var windowSize: Vector2 = Vector2.ZERO

func _ready() -> void:
    user_prefs = UserPreferences.load_or_create()
    windowSize = get_viewport().get_visible_rect().size
    if user_prefs.player_paddle:
        spawn_player_paddle(user_prefs.player_paddle)
    if user_prefs.cpu_player2_paddle:
        spawn_cpu_paddle(user_prefs.cpu_player2_paddle)
        
func spawn_player_paddle(paddleTyp: int):
    if paddleTyp == OptionsManager.paddleTyps.Standard:
        var player:Paddle = standardPaddle.instantiate()
        player.name = "Player"
        player.paddleTyp = paddleTyp
        player.get_node("Movment").paddle = player
        player.get_node("Movment").ball = $"%Ball"
        player.position.x = 50
        player.position.y = windowSize.y / 2
        $GamePanel.add_child(player)
    elif paddleTyp == OptionsManager.paddleTyps.CShape:
        var playerC:PaddleC = cPaddle.instantiate()
        playerC.name = "PlayerC"
        playerC.paddleTyp = paddleTyp
        playerC.get_node("Movement").paddle = playerC
        playerC.get_node("Movement").ball = $"%Ball"
        playerC.position.x = 50
        playerC.position.y = windowSize.y / 2
        $GamePanel.add_child(playerC)
    
func spawn_cpu_paddle(paddleTyp: int):
    if paddleTyp == OptionsManager.paddleTyps.Standard:
        var cpu:Paddle = standardPaddle.instantiate()
        cpu.name = "CPU"
        cpu.paddleTyp = paddleTyp
        cpu.get_node("Movment").paddle = cpu
        cpu.get_node("Movment").ball = $"%Ball"
        cpu.position.x = windowSize.x - 50
        cpu.position.y = windowSize.y / 2
        cpu.rotation_degrees = 180
        $GamePanel.add_child(cpu)
        
    elif paddleTyp == OptionsManager.paddleTyps.CShape:
        var cpuC: PaddleC = cPaddle.instantiate()
        cpuC.name = "CPUC"
        cpuC.paddleTyp = paddleTyp
        cpuC.get_node("Movement").paddle = cpuC
        cpuC.get_node("Movement").ball = $"%Ball"
        cpuC.position.x = windowSize.x - 50
        cpuC.position.y = windowSize.y / 2
        cpuC.rotation_degrees = 180
        $GamePanel.add_child(cpuC)
        


func _on_ball_timer_timeout() -> void:
    $"%Ball".new_Ball()


func _on_score_left_body_entered(_body: Node2D) -> void:
    score[1] += 1
    $GamePanel/HUD/CPUScore.text = str(score[1])
    $GamePanel/BallTimer.start()


func _on_score_right_body_entered(_body: Node2D) -> void:
    score[0] += 1
    $GamePanel/HUD/PlayerScore.text = str(score[0])
    $GamePanel/BallTimer.start()
