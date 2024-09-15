extends CharacterBody2D

class_name PlayerNode

#player input
var paused := false
var pausepress : bool
var movement_input := Vector2.ZERO
var jump_input := false
var jump_input_actuation := false
var jump_just_released := false
var climb_input := false
var attack_input := false
var down_test_input := false

#player movement
const jump_hang_gravity = 0
const jump_height : float = 96
const variable_jump_height : float = 96
const jump_time_to_peak : float = 0.6
const jump_time_to_descent : float = 0.45
const SPEED = 400
const MAX_SPEED = 560
const ACCELERATION = 1600
const AIR_ACCELERATION = 960
const FRICTION = 620
const AIR_FRICTION = 60
const CLIMB_FRICTION = 1200
const MAX_STEP_HEIGHT = -88
var _snapped_to_stairs_last_frame := false
var _last_frame_was_on_floor = -INF

var jump_hang : bool
var prev_slide_dir
var last_direction := Vector2.RIGHT
var current_gravity : float

#mechanics
var health := 60.0
var coyote := false
var touched_floor := false
var prev_velocity : Vector2 = Vector2.ZERO
var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
var variable_jump_gravity : float = ((jump_velocity * jump_velocity) / (2 * variable_jump_height))
var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
var can_jump : bool
var can_multijump := false
var jump_count : int
var max_jumps : int = 1
var jump_buffer := false
var jump_after_climb_coyote := false
var wall_jump_buffer := false
var climbing := false
var downed := false
var attack_duration := 0.1
var attack_angle
var attack_force := Vector2(500,500)
var attacking := false
var weapon


#states
var current_state = null
var prev_state = null

#nodes
@onready var STATES = $STATES
@onready var Raycasts = $Raycasts
@onready var Camera = $Camera2D
@onready var Arm = $Arm

#scripts
var Weapon = load("res://scenes/weapon/weapon.gd")

func _ready():
	_spawn_weapon_in_hand()
	
	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
	prev_state = STATES.IDLE
	current_state = STATES.IDLE
	
	GlobalScript.game_state.the_player = self

func _process(delta):
	Arm.look_at(Arm.get_global_mouse_position())
	
	if jump_count >= max_jumps:
		can_jump = false
	elif jump_count < max_jumps:
		can_jump = true
	if is_on_floor():
		jump_count = 0

func _physics_process(delta):
	if is_on_floor(): _last_frame_was_on_floor = Engine.get_physics_frames()
	velocity = velocity.clamp(Vector2(-MAX_SPEED,-MAX_SPEED), Vector2(MAX_SPEED,MAX_SPEED))
	prev_velocity = velocity

	if !downed:
		if attack_input:
			if !attacking:
				_attack()

	const DAMAGE_RATE = 5.0
	var overlapping_mobs = $HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		for mob in overlapping_mobs:
			if mob.is_in_group("Enemy"):
				health -= DAMAGE_RATE  * delta
				if health <= 0.0:
					queue_free()
	$CanvasLayer/HealthBar.value = health

	_camera_peak()
	player_input()
	change_state(current_state.update(delta))
	if not _snap_up_stairs_check(delta):
		move_and_slide()
		_snap_down_to_stairs_check()
	print(_snap_up_stairs_check(delta))

func change_state(input_state):
	if input_state != null: 
		prev_state = current_state
		current_state = input_state

		prev_state.exit_state()
		current_state.enter_state()

func gravity():
	if velocity.y < 0:
		current_gravity = variable_jump_gravity
	else:
		current_gravity = fall_gravity
	if jump_hang:
			current_gravity = jump_hang_gravity

	velocity.y += current_gravity * get_physics_process_delta_time()

func _snap_down_to_stairs_check() -> void:
	var did_snap := false
	var floor_below : bool = $StepCheckRays/bottom.is_colliding() and not is_surface_too_steep($StepCheckRays/bottom.get_collision_normal())
	var was_on_floor_last_frame = Engine.get_physics_frames() - _last_frame_was_on_floor == 1
	if not is_on_floor() and velocity.y >= 0 and (was_on_floor_last_frame or _snapped_to_stairs_last_frame) and floor_below:
		var body_test_result = PhysicsTestMotionResult2D.new()
		if _run_body_test_motion(self.global_transform, Vector2(0, - MAX_STEP_HEIGHT), body_test_result):
			var translate_y = body_test_result.get_travel().y
			self.position.y += translate_y
			apply_floor_snap()
			did_snap = true
	_snapped_to_stairs_last_frame = did_snap

func is_surface_too_steep(normal : Vector2) -> bool:
	return (normal.angle_to(Vector2.UP) > self.floor_max_angle)

func _run_body_test_motion(from : Transform2D, motion : Vector2, result = null) -> bool:
	if not result: result = PhysicsTestMotionResult2D.new()
	var params = PhysicsTestMotionParameters2D.new()
	params.from = from
	params.motion = motion
	return PhysicsServer2D.body_test_motion(self.get_rid(), params, result)

func _snap_up_stairs_check(delta) -> bool:
	if not is_on_floor() and not _snapped_to_stairs_last_frame: return false
	var expected_move_motion = self.velocity * Vector2(1,0) * delta
	var step_pos_with_clearance = self.global_transform.translated(expected_move_motion + Vector2(0, MAX_STEP_HEIGHT * 2))
	var down_check_result = PhysicsTestMotionResult2D.new()
	if (_run_body_test_motion(step_pos_with_clearance, Vector2(0, - MAX_STEP_HEIGHT * 2), down_check_result)
	and (down_check_result.get_collider().is_class("CollisionShape2D"))):
		var step_height = ((step_pos_with_clearance.origin + down_check_result.get_travel()) - self.global_position).y
		if step_height < MAX_STEP_HEIGHT or step_height >= -0.01 or (down_check_result.get_collision_point() - self.global_position).y < MAX_STEP_HEIGHT: return false
		%stepforward.global_position = down_check_result.get_collision_point() + Vector2(0, MAX_STEP_HEIGHT) + expected_move_motion.normalized() * 0.1
		%stepforward.force_raycast_update()
		if %stepforward.is_colliding() and not is_surface_too_steep(%stepforward.get_collision_normal()):
			self.global_position = step_pos_with_clearance.origin + down_check_result.get_travel()
			apply_floor_snap()
			_snapped_to_stairs_last_frame = true
			return true
	return false

func attempt_correction(amount: int):
	if test_move(global_transform, Vector2(0, velocity.y * get_physics_process_delta_time())):
		for i in range(1, amount*2+1):
			for j in [-1.0, 1.0]:
				if !test_move(global_transform.translated(Vector2(i*j/2, 0)),
							Vector2(0, velocity.y* get_physics_process_delta_time())):
					translate(Vector2(i*j/2, 0))
					if velocity.x * j < 0:
						velocity.x = 0
					return

func _spawn_weapon_in_hand():
	const WEAPON = preload("res://scenes/weapon/weapon.tscn")
	var new_weapon = WEAPON.instantiate()
	$Arm/Marker2D.add_child(new_weapon)
	
	GlobalScript.game_state.hotbar.weapon = new_weapon

func _attack():
	var the_weapon = GlobalScript.game_state.hotbar.weapon
	
	the_weapon.shoot_mech()
	
func take_damage():
	health -= 1
	if health == 0:
		queue_free()



func _camera_peak():
	var sensitivity = 6
	var mouse_pos = get_local_mouse_position()
	Camera.position = (mouse_pos / sensitivity)

func _input(event: InputEvent):
	if (event.is_action_pressed("MoveDown")) && is_on_floor():
		position.y += 1

func player_input():
	movement_input = Vector2.ZERO
	if Input.is_action_pressed("MoveRight"):
		movement_input.x += 1
	if Input.is_action_pressed("MoveLeft"):
		movement_input.x -= 1
	if Input.is_action_pressed("MoveUp"):
		movement_input.y -= 1
	if Input.is_action_pressed("MoveDown"):
		movement_input.y += 1

	#utility
	if Input.is_action_just_pressed("Pause"):
		paused = !paused
	if Input.is_action_just_pressed("ResetScene"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("DownTest"):
		down_test_input = true
	else:
		down_test_input = false

	#movement
	if Input.is_action_pressed("Jump"):
		jump_input = true
	else: 
		jump_input = false
	if Input.is_action_just_pressed("Jump"):
		jump_input_actuation = true
	else: 
		jump_input_actuation = false
	if Input.is_action_just_released("Jump"):
		jump_just_released = true
	else:
		jump_just_released = false

	if Input.is_action_pressed("Climb"):
		climb_input = true
	else:
		climb_input = false

	#attack
	if Input.is_action_pressed("Attack"):
		attack_input = true
	else:
		attack_input = false
