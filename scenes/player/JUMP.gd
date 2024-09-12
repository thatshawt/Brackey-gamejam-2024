extends "state.gd"

func update(delta):
	Player.attempt_correction(4)
	Player.gravity()
	player_movement()

	if Player.touched_wall:
		if Player.jump_just_released:
			Player.velocity = lerp(Player.velocity, Vector2(0,0), 0.4)
	else:
		if Player.jump_just_released:
			Player.velocity.y = lerp(Player.velocity.y, 0.0, 0.4)

	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.get_next_to_wall() != null:
		if Player.movement_input.x == Player.get_next_to_wall().x:
			return STATES.CLIMB
	if Player.jump_input:
		if Player.can_jump:
			return STATES.JUMP
	if Player.down_test_input:
		return STATES.DOWN
	return null

func enter_state():
	Player.jump_count += 1

	if Player.can_jump or Player.coyote:
		Player.velocity.y = Player.jump_velocity
		if Player.get_next_to_wall() != null:
			if !Player.is_on_floor():
				Player.velocity.x = Player.get_next_to_wall().x * Player.jump_velocity
		elif Player.prev_state == STATES.FALL:
			if Player.wall_jump_coyote() != null:
				Player.velocity.x = Player.wall_jump_coyote().x * Player.jump_velocity
	Player.coyote = false
