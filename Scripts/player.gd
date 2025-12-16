extends CharacterBody2D


# Velocidade do personagem (em pixels por segundo)

func _physics_process(delta):
	var direction = Vector2.ZERO
	var speed: float = 600.0

	# Movimento via teclado (pode adaptar para touch depois)
	if Input.is_action_pressed("move_right"):
		direction.x = direction.x + 1
	if Input.is_action_pressed("move_left"):
		direction.x = direction.x - 1
	if Input.is_action_pressed("move_down"):
		direction.y = direction.y + 1
	if Input.is_action_pressed("move_up"):
		direction.y = direction.y - 1

	# Normaliza o vetor para manter a velocidade constante em diagonais
	direction = direction.normalized()

	# Define a velocidade final
	velocity = direction * speed

	# Move o personagem respeitando colisões
	move_and_slide()
