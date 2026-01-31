class_name PlayerWalkState
extends PlayerState

const SPEED: float = 2

func enter() -> void:
	player.animation.play(walk_anim)

func process_physics(delta: float) -> State:
	super(delta)
	do_move(get_move_dir())
	return null

func get_move_dir() -> float: return Input.get_axis("move_left", "move_right")

func do_move(move_dir: float) -> void: player.velocity.x = move_dir * SPEED
