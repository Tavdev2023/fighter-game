class_name PlayerState
extends State

@onready var player: Player = get_tree().get_first_node_in_group("Player")

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity", -9.8)

# Animation Names
var idle_anim: String = "Idle"
var walk_anim: String = "Walk"

#States
@export_group("States")
@export var idle_state: PlayerState
@export var walk_state: PlayerState

#Inputs
var movement_key: String = "movement_key"
var move_left: String = "move_left"
var move_right: String = "move_right"

#Base Fn
func process_physics(delta: float) -> State:
	player.velocity.y += gravity * delta
	player.move_and_slide()
	return null
