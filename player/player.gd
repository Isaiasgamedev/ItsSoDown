extends KinematicBody2D
const GRAVITY = 1500 #Gravidade
export (int) var speed = 200
var jumpForce = -600 #Força de pulo

var target = Vector2()
var velocity = Vector2()

func _physics_process(delta):
	velocity.y += GRAVITY * delta #Funcionamento da Gravidade
	#_____________________________________________________________
	#---------Controle de Movimento Basico-----------------------#
	if Input.is_action_pressed("ui_left"): #Mover para esquerda
		$sprite.flip_h = true
		$sprite.play("move")
		velocity.x = -speed #Velocidade para Esquerda
		$ray.rotation_degrees = 90


	elif Input.is_action_pressed("ui_right"): #Mover para direita
		$sprite.flip_h = false
		$sprite.play("move")
		velocity.x = speed #Velocidade para Direita
		$ray.rotation_degrees = -90

	
	else:
		$sprite.stop()
		velocity.x = 0
	
	var jump = Input.is_action_just_pressed("ui_up")
	var jump_stop = Input.is_action_just_released("ui_up")
	
	if is_on_floor(): #Verificação se está no chão
		if jump: #Velocidade para Pulo
			$sprite.stop()
			velocity.y = jumpForce #Força do pulo
	elif jump_stop and velocity.y < 0: #Verificação da parada no pulo
			velocity.y *= 0.3 #Velocidade da Queda pós pulo
	
	if $ray.is_colliding() and Input.is_action_pressed("ui_right"):
		var body = $ray.get_collider()
		if body.bloco_confirm == true:
			body.move_and_slide(Vector2(5000, 0) * delta)
		
		
	if $ray.is_colliding() and Input.is_action_pressed("ui_left"):
		var body = $ray.get_collider()
		if body.bloco_confirm == true:
			body.move_and_slide(Vector2(-5000, 0) * delta)
	
	else:
		pass
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
