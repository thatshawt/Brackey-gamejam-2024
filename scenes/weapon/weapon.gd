extends Sprite2D
class_name Weapon

var bullet_speed_multiplier : float
var level : int = 0
var current_weapon : weapons
enum weapons {Bow,Crossbow,Flintlock,Deagle,Shotgun,M16,Rocket_Launcher,Beam_Emitter}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot():
	var marker_thang: Marker2D = GlobalScript.game_state.the_player.Arm.get_node("Marker2D")
	
	const BULLET = preload("res://scenes/player/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = marker_thang.global_position
	new_bullet.global_rotation = marker_thang.global_rotation
	marker_thang.add_child(new_bullet)
	
