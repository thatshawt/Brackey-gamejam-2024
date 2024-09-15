extends Sprite2D
class_name Weapon

enum weapons {Bow, Crossbow, Flintlock, Handgun, Shotgun, Machine_Gun, Rocket_Launcher, Beam_Emitter}
var gun_level: int = GlobalScript.game_state.upgrades_state.get_upgrade_level(Upgrades.UpgradeType.Weapon_Next_Gun)
var fire_interval : float
var bullet_damage : float
var bullet_max_hits : int

func _ready():
	set_stats()

func set_stats():
	match gun_level:
		1: #Bow
			fire_interval = 1.8
			bullet_damage = 20
			bullet_max_hits = 1
		2: #Crossbow
			fire_interval = 1.0
			bullet_damage = 20
			bullet_max_hits = 1
		3: #Flintlock
			fire_interval = 0.6
			bullet_damage = 20
			bullet_max_hits = 2
		4: #Handgun
			fire_interval = 0.3
			bullet_damage = 25
			bullet_max_hits = 4
		5: #Shotgun
			fire_interval = 0.4
			bullet_damage = 88
			bullet_max_hits = 3
		6: #Machine_Gun
			fire_interval = 0.1
			bullet_damage = 25
			bullet_max_hits = 4
		7: #Rocket_Launcher
			fire_interval = 0.8
			bullet_damage = 148
			bullet_max_hits = 1
		8: #Beam_Emitter
			fire_interval = 0.0
			bullet_damage = 248
			bullet_max_hits = 108

func shoot_mech():
	const BULLET = preload("res://scenes/player/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = $Marker2D.global_position
	new_bullet.global_rotation = $Marker2D.global_rotation
	$Marker2D.add_child(new_bullet)
	
	GlobalScript.game_state.the_player.attacking = true
	await get_tree().create_timer(fire_interval).timeout
	GlobalScript.game_state.the_player.attacking = false
