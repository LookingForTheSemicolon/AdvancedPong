extends Sprite2D


var score := [0,0] #0:Player, 1:CPI
const PADDLE_SPEED: int = 500

func _ready() -> void:
    var options = OptionsManager.read_options()
    

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
