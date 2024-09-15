extends "state.gd"

var swim_speed := 200.0

func update(delta):
	player_movement()
	swim_movement(delta)
	
	if !Player.swimming:
		return STATES.IDLE
		if Player.velocity.y > 0:
			return STATES.FALL
		if Player.climbing:
			if Player.movement_input.y < 0:
				return STATES.CLIMB
		if Player.jump_input:
			if Player.can_jump:
				return STATES.JUMP
	return null

func swim_movement(delta):
	Player.position.y += 0.2
	
	if Player.movement_input.y < 0:
		Player.velocity.y = lerp(Player.velocity.y, -swim_speed, 0.2)
	elif Player.movement_input.y > 0:
		Player.velocity.y = lerp(Player.velocity.y, swim_speed, 0.2)
	elif !Player.movement_input.y:
			Player.velocity.y = lerp(Player.velocity.y, 0.0, 0.4)
			
	if Player.movement_input.x < 0:
		Player.velocity.x = lerp(Player.velocity.x, -swim_speed, 0.2)
	elif Player.movement_input.x > 0:
		Player.velocity.x = lerp(Player.velocity.x, swim_speed, 0.2)
	elif !Player.movement_input.x:
			Player.velocity.x = lerp(Player.velocity.x, 0.0, 0.4)

func enter_state():
	Player.jump_count = 0
	Player.velocity = lerp(Player.velocity, Vector2.ZERO, 0.4)
