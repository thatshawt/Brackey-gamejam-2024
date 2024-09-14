extends Sprite2D
class_name Weapon

var weapon_fire_interval : float
var level : int = 0
var current_weapon : weapons
enum weapons {Bow,Crossbow,Flintlock,Deagle,Shotgun,M16,Rocket_Launcher,Beam_Emitter}



func shoot():
	#var marker_thang: Marker2D = GlobalScript.game_state.the_player.Arm.get_node("Marker2D")
	
	const BULLET = preload("res://scenes/player/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = $Marker2D.global_position
	new_bullet.global_rotation = $Marker2D.global_rotation
	$Marker2D.add_child(new_bullet)
