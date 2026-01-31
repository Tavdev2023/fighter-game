class_name Player
extends CharacterBody2D

@export var move_speed: float = 260.0
@export var jump_velocity: float = -520.0
@export var gravity: float = 1400.0
@export var accel: float = 1800.0
@export var decel: float = 2200.0

@export_group("States")
@export var punch_state: PlayerState
@export var kick_state: PlayerState

@onready var animation: AnimationPlayer = $Animation
@onready var state_machine: StateMachine = $"State Machine"

func _ready(): state_machine.init()
	
func _process(delta): state_machine.process_frame(delta)
	
func _physics_process(delta): state_machine.process_physics(delta)

func _input(event): state_machine.process_input(event)
