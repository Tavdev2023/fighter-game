extends Node
class_name State

func enter(): pass
func exit(): pass

func process_frame(delta: float) -> State:
	return null

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
