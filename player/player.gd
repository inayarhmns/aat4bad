extends CharacterBody2D


const JUMP_VELOCITY = -400.0
const SPEED = 180.0
const ACC: int = 60
@export var jump_velo: float = 500
@export var jump_gravity: float = -30
@export var fall_gravity: float = 160
@onready var sprite = $AnimatedSprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var dir: Vector2 = input()
	move(dir)
	jump()
	play_animation()
	move_and_slide()
	
func move(dir):
	velocity = velocity.move_toward(dir*SPEED, ACC)

func input() -> Vector2:
	var dir = Vector2.ZERO
	dir.x = Input.get_axis("ui_left", "ui_right")
	dir = dir.normalized()
	return dir

func jump():
	velocity.y += get_gravity()
	if (Input.is_action_pressed("ui_up") && is_on_floor()):
		#jump_sound.play()
		velocity.y = -jump_velo
			
func get_gravity():
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func play_animation():
	if input().x == 0:
		sprite.stop()
	if input().x == 1:
		sprite.play("RIGHT")
	elif input().x == -1:
		sprite.play("LEFT")
