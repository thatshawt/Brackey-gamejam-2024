extends Sprite2D
class_name Weapon

var bullet_speed_multiplier : float
var level : int = 0
var current_weapon : weapons
enum weapons {Bow,Crossbow,Flintlock,Deagle,Shotgun,M16,Rocket_Launcher,Beam_Emitter}
var weapon_class = Weapon.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot():
	#const BULLET = preload("res://scenes/player/bullet.tscn")
	#var new_bullet = BULLET.instantiate()
	#new_bullet.global_position = $Arm/Marker2D.global_position
	#new_bullet.global_rotation = $Arm/Marker2D.global_rotation
	#$Arm/Marker2D.add_child(new_bullet)
	pass
