extends CharacterBody2D

@export var move_speed: float = 260.0
@export var jump_velocity: float = -520.0
@export var gravity: float = 1400.0

# (Opcional) aceleração/desaceleração pra ficar mais "Street Fighter"
@export var accel: float = 1800.0
@export var decel: float = 2200.0

func _physics_process(delta: float) -> void:
	# Gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Evita ficar acumulando pequenas velocidades verticais
		velocity.y = 0.0

	# Entrada horizontal (esquerda/direita)
	var input_dir := Input.get_axis("ui_left", "ui_right") # -1 .. +1
	var target_x := input_dir * move_speed

	# Move com aceleração/desaceleração (mais "peso")
	if input_dir != 0.0:
		velocity.x = move_toward(velocity.x, target_x, accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, decel * delta)

	# Pulo (só no chão)
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_velocity

	# Aplica movimento com colisão
	move_and_slide()
