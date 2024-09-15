extends Sprite2D
class_name Weapon

var weapon_fire_interval := 0.6
#var gun_level: int = GlobalScript.game_state.upgrades_state.get_upgrade_level(Upgrades.UpgradeType.Weapon_Next_Gun)

#func _physics_process(delta):
	#print(gun_level)

func shoot_mech():
	const BULLET = preload("res://scenes/player/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = $Marker2D.global_position
	new_bullet.global_rotation = $Marker2D.global_rotation
	$Marker2D.add_child(new_bullet)
	
	GlobalScript.game_state.the_player.attacking = true
	await get_tree().create_timer(weapon_fire_interval).timeout
	GlobalScript.game_state.the_player.attacking = false

func shoot_init():
	#match gun_level:
		pass
