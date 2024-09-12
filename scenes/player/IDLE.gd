extends "state.gd"

func update(delta):
	Player.gravity()
	if Player.is_on_floor:
		if Player.jump_buffer:
			return STATES.JUMP
	if Player.movement_input.x != 0 or Player.velocity.x != 0:
		return STATES.MOVE
	if Player.jump_input:
		if Player.can_jump:
			return STATES.JUMP
	if Player.velocity.y > 0:
		if !Player.is_on_floor():
			return STATES.FALL
	if Player.down_test_input:
		return STATES.DOWN
	return null
