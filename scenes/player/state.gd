extends Node

var STATES = null
var Player = null

func enter_state():
	pass
func exit_state():
	pass
func update(delta):
	return null

func xvelocity(FRICTION, SPEED, ACC):
	Player.velocity.x = move_toward(Player.velocity.x, 0, FRICTION * get_process_delta_time())
	if Player.movement_input.x >0:
		Player.velocity.x = move_toward(Player.velocity.x, SPEED, ACC * get_process_delta_time())
	elif Player.movement_input.x <0:
		Player.velocity.x = move_toward(Player.velocity.x, - SPEED, ACC * get_process_delta_time())

func player_movement():
	if Player.movement_input.x > 0:
		Player.last_direction = Vector2.RIGHT
	elif Player.movement_input.x < 0:
		Player.last_direction = Vector2.LEFT

	if Player.is_on_floor():
		xvelocity(Player.FRICTION, Player.SPEED, Player.ACCELERATION)
	else:
		xvelocity(Player.AIR_FRICTION, Player.SPEED, Player.AIR_ACCELERATION)
