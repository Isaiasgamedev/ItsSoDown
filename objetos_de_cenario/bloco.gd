extends KinematicBody2D

const GRAVITY = 1500 #Gravidade
var velocity = Vector2()
var bloco_confirm = true

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))