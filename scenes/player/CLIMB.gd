extends "state.gd"

const climb_speed := 200.0

func update(delta):
	player_movement()
	slide_movement(delta)
	if !Player.climbing:
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
	if Player.movement_input.y < 0:
		Player.velocity.y = lerp(Player.velocity.y, -climb_speed, 0.4)
	elif Player.movement_input.y > 0:
		Player.velocity.y = lerp(Player.velocity.y, climb_speed, 0.1)
	elif !Player.movement_input.y:
			Player.velocity.y = 0


func enter_state():
	Player.jump_count = 0
	Player.slide_on_ceiling = false

func exit_state():
	Player.slide_on_ceiling = true
