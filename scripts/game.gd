extends Node2D

var score := [0,0] #0:Player, 1:CPI

const PADDLE_SPEED: int = 500

func switch_player_paddle(paddleTyp: int):
    if paddleTyp == OptionsManager.paddleTyps.Standard:
        $Player.set_process(true)
        $PlayerC.queue_free()
    elif paddleTyp == OptionsManager.paddleTyps.CShape:
        $PlayerC.set_process(true)
        $Player.queue_free()
    
func switch_cpu_paddle(paddleTyp: int):
    if paddleTyp == OptionsManager.paddleTyps.Standard:
        $CPU.set_process(true)
        $CPUC.queue_free()
    elif paddleTyp == OptionsManager.paddleTyps.CShape:
        $CPUC.set_process(true)
        $CPU.queue_free()
        

func _ready() -> void:
    var options = OptionsManager.read_options()
    if options.has("player_paddle"):
        var option = options.player_paddle
        if option == OptionsManager.paddleTyps.Standard:
            switch_player_paddle(OptionsManager.paddleTyps.Standard)
        elif option == OptionsManager.paddleTyps.CShape:
            switch_player_paddle(OptionsManager.paddleTyps.CShape)
    if options.has("cpu_paddle"):
         if options.cpu_paddle == OptionsManager.paddleTyps.Standard:
            switch_cpu_paddle(OptionsManager.paddleTyps.Standard)
         elif options.cpu_paddle == OptionsManager.paddleTyps.CShape:
            switch_cpu_paddle(OptionsManager.paddleTyps.CShape)

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
