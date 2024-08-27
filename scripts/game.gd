extends Sprite2D

@onready var player_scene = preload("res://scenes/PlayerPaddles/Default/player.tscn") as PackedScene
@onready var player2_scene = preload("res://scenes/PlayerPaddles/CShape/player2.tscn") as PackedScene
@onready var cpu_scene = preload("res://scenes/PlayerPaddles/Default/cpu.tscn") as PackedScene

var score := [0,0] #0:Player, 1:CPI
const PADDLE_SPEED: int = 500

func _ready() -> void:
    var options = OptionsManager.read_options()
    if options.has("player_paddle"):
        if options.player_paddle.name == "Standard":
            var player = player_scene.instantiate()
            get_tree().current_scene.add_child(player)
        if options.player_paddle.name == "C-Shape":
            var player2 = player2_scene.instantiate()
            get_tree().current_scene.add_child(player2)
    if options.has("cpu_paddle"):
         if options.cpu_paddle.name == "Standard":
            var cpu = cpu_scene.instantiate()
            get_tree().current_scene.add_child(cpu)

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
