extends "state.gd"

func update(delta):
	Player.gravity()
	player_movement()
	if Player.velocity.x == 0 and !Player.downed:
		return STATES.IDLE
	elif Player.velocity.x == 0 and Player.downed:
		return STATES.DOWN
	if Player.velocity.y > 0:
		if !Player.is_on_floor():
			return STATES.FALL
	if Player.climbing:
		if Player.movement_input.y < 0:
			return STATES.CLIMB
	if Player.jump_input:
		if Player.can_jump:
			return STATES.JUMP
	if Player.down_test_input:
		return STATES.DOWN
	return null
