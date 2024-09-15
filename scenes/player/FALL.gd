extends "state.gd"

const vault_time := 0.5
const coyoteduration := 0.1
const jump_hang_time := 0.1
const jump_buffer_time := 0.2

func update(delta):
	Player.gravity()
	player_movement()

	if Player.is_on_floor():
		return STATES.IDLE
	if Player.climbing:
		if Player.movement_input.y < 0:
			return STATES.CLIMB
	if Player.jump_input:
		if Player.can_jump or Player.coyote:
			return STATES.JUMP
		elif !Player.can_jump:
			Player.jump_buffer = true
			get_tree().create_timer(jump_buffer_time).timeout.connect(on_jump_buffer_timeout)
	if Player.swimming:
		return STATES.SWIM
	if Player.down_test_input:
		return STATES.DOWN
	return null

func enter_state():
	Player.jump_count += 1
	Player.jump_hang = true
	get_tree().create_timer(jump_hang_time).timeout.connect(_on_jump_hang_timeout)
	
	if Player.prev_state == STATES.MOVE:
		Player.touched_floor = true
	if Player.prev_state == STATES.CLIMB:
		Player.wall_jump_buffer = true
	if Player.touched_floor or Player.prev_state == STATES.CLIMB:
		Player.coyote = true
		get_tree().create_timer(coyoteduration).timeout.connect(_on_coyote_time_timeout)

func exit_state():
	Player.jump_hang = false

func _on_jump_hang_timeout():
	Player.jump_hang = false

func _on_coyote_time_timeout():
	Player.touched_floor = false
	Player.wall_jump_buffer = false
	Player.coyote = false

func on_jump_buffer_timeout() -> void:
	Player.jump_buffer = false
