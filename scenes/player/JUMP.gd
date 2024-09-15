extends "state.gd"

func update(delta):
	Player.attempt_correction(4)
	Player.gravity()
	player_movement()

	if Player.jump_just_released:
		Player.velocity.y = lerp(Player.velocity.y, 0.0, 0.4)

	if Player.velocity.y > 0:
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

func enter_state():
	Player.jump_count += 1

	if Player.can_jump or Player.coyote:
		Player.velocity.y = Player.jump_velocity
	Player.coyote = false
	
	if Player.prev_state == STATES.CLIMB:
		Player.jump_after_climb_coyote = true
		
func exit_state():
	Player.jump_after_climb_coyote = false
	
