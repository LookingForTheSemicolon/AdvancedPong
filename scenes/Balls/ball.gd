extends CharacterBody2D

var win_size: Vector2
const START_SPEED: int = 500
const ACCEL:int = 50
var speed: int
var dir: Vector2
const MAX_Y_VECTOR: float = 0.6

func _ready() -> void:
    win_size = get_viewport_rect().size
    
func new_Ball():
    #random start and direction
    position.x = win_size.x / 2
    position.y = randi_range(200, win_size.y - 200)
    speed = START_SPEED
    dir = random_direction()

func _physics_process(delta: float) -> void:
    var collision = move_and_collide(dir * speed * delta)
    var collider
    if collision:
        collider = collision.get_collider()
        #ball hits paddle
        print(position)
        if collider == $"../Player" or collider == $"../CPU":
            speed += ACCEL
            dir = new_direction(collider, null)
        elif collider == $"../Player2":
            dir = new_direction(collider, collision)
        #ball hits wall
        else:
            dir = dir.bounce(collision.get_normal())
    
func random_direction():
    var new_dir := Vector2()
    new_dir.x = [1,-1].pick_random()
    new_dir.y = randf_range(-1,1)
    return new_dir.normalized()
    
func new_direction(collider, collision):
    var ball_y = position.y
    var pad_y = collider.position.y
    var dist = ball_y - pad_y
    var new_dir := Vector2()
    #if hit on Top or Bottom Paddle -> just bounce
    if(position.x > 65.5 && collision != null):
       new_dir = dir.bounce(collision.get_normal())
       return new_dir.normalized()
    else:
    #flip direction
        if dir.x > 0:
            new_dir.x = -1
        else:
            new_dir.x = 1
            
        new_dir.y = (dist / (collider.p_height / 2)) * MAX_Y_VECTOR
        speed += ACCEL
        return new_dir.normalized()
