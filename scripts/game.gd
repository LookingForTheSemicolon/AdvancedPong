extends Sprite2D

var score := [0,0] #0:Player, 1:CPI

const PADDLE_SPEED: int = 500

func show_standard_paddle():
    $Player.set_process(true)
    $PlayerC.set_process(false)
    $PlayerC.visible = false
    
func hide_standard_paddle():
    $PlayerC.set_process(true)
    $Player.set_process(false)
    $Player.visible = false

func _ready() -> void:
    var options = OptionsManager.read_options()
    if options.has("player_paddle"):
        if options.player_paddle.name == "Standard":
            show_standard_paddle()
        if options.player_paddle.name == "C-Shape":
            hide_standard_paddle()
    if options.has("cpu_paddle"):
         if options.cpu_paddle.name == "Standard":
            $CPU.set_process(true)
            $CPU.visible = true

func _on_ball_timer_timeout() -> void:
    $Ball.new_Ball()


func _on_score_left_body_entered(_body: Node2D) -> void:
    score[1] += 1
    $HUD/CPUScore.text = str(score[1])
    $BallTimer.start()


func _on_score_right_body_entered(_body: Node2D) -> void:
    score[0] += 1
    $HUD/PlayerScore.text = str(score[0])
    $BallTimer.start()
