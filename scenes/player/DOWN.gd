extends "state.gd"

func update(delta):
	Player.gravity()
	if Player.is_on_floor():
		if Player.velocity.x != 0:
			return STATES.MOVE
	if Player.movement_input.y < 0:
		Player.downed = false
		return STATES.IDLE

func enter_state():
	Player.downed = true
func exit_state():
	pass
