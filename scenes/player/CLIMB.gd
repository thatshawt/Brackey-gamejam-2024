extends "state.gd"

const fast_descent := 180.0
const climb_speed := 180.0
const slide_friction := 0.86

func update(delta):
	Player.gravity()
	player_movement()
	slide_movement(delta)
	if Player.get_next_to_wall() == null:
		if !Player.is_on_floor():
			return STATES.FALL
		else:
			return STATES.IDLE
			if Player.velocity.x != 0:
				return STATES.MOVE
	else:
		if Player.is_on_floor():
			if !Player.climb_input:
				return STATES.IDLE
	if Player.jump_input:
		if Player.can_jump:
			return STATES.JUMP
	if Player.down_test_input:
		return STATES.DOWN
	return null

func slide_movement(delta):
	if Player.climb_input:
		if Player.movement_input.y < 0:
			Player.velocity.y = lerp(Player.velocity.y, -climb_speed, 0.4)
		elif Player.movement_input.y > 0:
			Player.velocity.y = lerp(Player.velocity.y, climb_speed, 0.1)
		else:
			Player.velocity.y = 0
	elif Player.movement_input.y > 0:
		Player.velocity.y = lerp(Player.velocity.y, fast_descent, 0.1)
	else:
		Player.velocity.y *= slide_friction

func enter_state():
	Player.slide_on_ceiling = false

func exit_state():
	Player.slide_on_ceiling = true
