extends CharacterBody2D

@export var move_speed: float = 260.0
@export var jump_velocity: float = -520.0
@export var gravity: float = 1400.0
# (Opcional) aceleração/desaceleração pra ficar mais "Street Fighter"
@export var accel: float = 1800.0
@export var decel: float = 2200.0

@export_group("States")
@export var punch_state: PlayerState
@export var kick_state: PlayerState

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Evita ficar acumulando pequenas velocidades verticais
		velocity.y = 0.0

	# Entrada horizontal (esquerda/direita)
	var input_dir := Input.get_axis("move_left_p1", "move_right_p1") # -1 .. +1
	var target_x := input_dir * move_speed

	# Move com aceleração/desaceleração (mais "peso")
	if input_dir != 0.0:
		velocity.x = move_toward(velocity.x, target_x, accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, decel * delta)

	# Pulo (só no chão)
	if is_on_floor() and Input.is_action_just_pressed("jump_p1"):
		velocity.y = jump_velocity

	# Aplica movimento com colisão
	move_and_slide()
	
	# Flip do sprite (se quiser que vire pra esquerda/direita)
	if input_dir != 0.0:
		anim.flip_h = input_dir < 0.0

	_update_animation(input_dir)

func _update_animation(input_dir: float) -> void:
	# No ar: jump/fall
	if not is_on_floor():
		if velocity.y < 0.0:
			_play_if_not("jump")
		else:
			# se você não tiver "fall", pode tocar "jump" também
			if anim.sprite_frames.has_animation("idle"):
				_play_if_not("idle")
			else:
				_play_if_not("jump")
		return

	# No chão: walk/idle
	if abs(velocity.x) > 10.0:
		_play_if_not("walk")
	else:
		_play_if_not("idle")
		
	if Input.is_action_just_pressed("punch_p1"):
		_play_if_not("punch")
	if Input.is_action_just_pressed("kick_p1"):
		_play_if_not("kick")
		
func _play_if_not(name: String) -> void:
	if anim.animation != name:
		anim.play(name)
