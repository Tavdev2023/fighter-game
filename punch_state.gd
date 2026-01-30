extends PlayerState

func enter(player):
	player.anim.play("punch")

func update(player, delta):
	if !player.anim.is_playing():
		player.change_state(player.idle_state)
