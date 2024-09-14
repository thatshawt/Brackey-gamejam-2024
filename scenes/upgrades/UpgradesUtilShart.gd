extends Node

class_name Upgrades
# this code is not good but it works good enough
enum UpgradeType{
	Ship_Ship_HP,
	
	Player_Player_HP,
	Player_Player_Jumps,
	Player_Player_Speed,
	
	Roomba_Roomba_1,
	Roomba_Roomba_1_Speed,
	Roomba_Roomba_2,
	Roomba_Roomba_2_Speed,
	Roomba_Roomba_3,
	Roomba_Roomba_3_Speed,
	
	CrowsNest_Nest_1,
	CrowsNest_Nest_1_Reload_Time,
	CrowsNest_Nest_1_Bullet_Damage,
	CrowsNest_Nest_2,
	CrowsNest_Nest_2_Reload_Time,
	CrowsNest_Nest_2_Bullet_Damage,
	
	Traps_Water_Mine_1,
	Traps_Water_Mine_2,
	
	Weapon_Bullet_Count,
	Weapon_Reload_Time,
	Weapon_Next_Gun,			# 
	
	Ability_Stink_Candle,		# wards off enemies
	Ability_Bandaid,			# heals player
	Ability_Bullet_Frenzy, 		# lowers reload time player and snipers
	Ability_Coin_Multiplier,	# yea
	Ability_Instant_Mine_Reload,# reload mines
	Ability_Grenade_Throw,		# throws a grenade
	Ability_Buckshot,			# shoots strong buckshot bullets idk
} # help me

static func _get_category_name(stat: UpgradeType):
	var stat_name: String = UpgradeType.find_key(stat)
	
	var _first_underscore = stat_name.find("_")

	var stat_category = stat_name.substr(0, _first_underscore)
	var stat_upgrade_name = stat_name.substr(_first_underscore+1, -1).replace("_", " ")
	
	return stat_category
	
static func _get_stat_upgrade_name(stat: UpgradeType):
	var stat_name: String = UpgradeType.find_key(stat)
	
	var _first_underscore = stat_name.find("_")

	var stat_category = stat_name.substr(0, _first_underscore)
	var stat_upgrade_name = stat_name.substr(_first_underscore+1, -1).replace("_", " ")
	
	return stat_upgrade_name

class UpgradeData:
	var category: String
	var upgrade_name: String
	
	var unlocked: bool = true
	var level: int = 1
	var cost: int
	
	var is_ability: bool = false
	var is_bought: bool = false
	
	var no_more: bool = false
	
# i am drunk
class UpgradesState:
	var _level_map: Dictionary = {}
	
	var initial_costs = {
		UpgradeType.Roomba_Roomba_1: 1,
		UpgradeType.Roomba_Roomba_1_Speed: 1,
		UpgradeType.Roomba_Roomba_2: 1,
		UpgradeType.Roomba_Roomba_2_Speed: 1,
		UpgradeType.Roomba_Roomba_3: 1,
		UpgradeType.Roomba_Roomba_3_Speed: 1,
		
		UpgradeType.Player_Player_HP: 100,
		UpgradeType.Player_Player_Jumps: 1,
		UpgradeType.Player_Player_Speed: 1,
		
		UpgradeType.CrowsNest_Nest_1: 1,
		UpgradeType.CrowsNest_Nest_1_Bullet_Damage: 1,
		UpgradeType.CrowsNest_Nest_1_Reload_Time: 1,
		UpgradeType.CrowsNest_Nest_2: 1,
		UpgradeType.CrowsNest_Nest_2_Bullet_Damage: 1,
		UpgradeType.CrowsNest_Nest_2_Reload_Time: 1,
		
		UpgradeType.Traps_Water_Mine_1: 1,
		UpgradeType.Traps_Water_Mine_2: 1,
		
		UpgradeType.Ability_Stink_Candle: 100,
		UpgradeType.Ability_Bandaid: 100,
		UpgradeType.Ability_Bullet_Frenzy: 100,
		UpgradeType.Ability_Coin_Multiplier: 100,
		UpgradeType.Ability_Instant_Mine_Reload: 100,
		UpgradeType.Ability_Grenade_Throw: 100,
		UpgradeType.Ability_Buckshot: 100,
	}
	
	var weapon_bullet_upgrade_data = [
		100,200,300,400,500,600
	]
	
	var weapon_reload_upgrade_data = [
		100,200,300,400,500,600
	]
	
	var weapon_next_gun_data = [
		100,200,300,400,500,600
	]
	
	var jumps_data = [
		100, 200
	]
	
	func _get_roombaspeed_cost(level: int) -> int:
		return 1
		
	func _get_nestreload_cost(level: int) -> int:
		return 1
		
	func _get_nestdamage_cost(level: int) -> int:
		return 1
		
	func _get_mine_cost(level: int) -> int:
		return 1
	
	func _init():
		set_upgrade_level(UpgradeType.Ship_Ship_HP, 100)
		
		set_upgrade_level(UpgradeType.Roomba_Roomba_1, 0)
		set_upgrade_level(UpgradeType.Roomba_Roomba_1_Speed, 0)
		set_upgrade_level(UpgradeType.Roomba_Roomba_2, 0)
		set_upgrade_level(UpgradeType.Roomba_Roomba_2_Speed, 0)
		set_upgrade_level(UpgradeType.Roomba_Roomba_3, 0)
		set_upgrade_level(UpgradeType.Roomba_Roomba_3_Speed, 0)
	
		set_upgrade_level(UpgradeType.Player_Player_HP, 100)
		set_upgrade_level(UpgradeType.Player_Player_Jumps, 1)
		set_upgrade_level(UpgradeType.Player_Player_Speed, 1)
		
		set_upgrade_level(UpgradeType.CrowsNest_Nest_1, 0)
		set_upgrade_level(UpgradeType.CrowsNest_Nest_1_Bullet_Damage, 0)
		set_upgrade_level(UpgradeType.CrowsNest_Nest_1_Reload_Time, 0)
		set_upgrade_level(UpgradeType.CrowsNest_Nest_2, 0)
		set_upgrade_level(UpgradeType.CrowsNest_Nest_2_Bullet_Damage, 0)
		set_upgrade_level(UpgradeType.CrowsNest_Nest_2_Reload_Time, 0)
		
		set_upgrade_level(UpgradeType.Traps_Water_Mine_1, 0)
		set_upgrade_level(UpgradeType.Traps_Water_Mine_2, 0)
		
		set_upgrade_level(UpgradeType.Weapon_Bullet_Count, 1)
		set_upgrade_level(UpgradeType.Weapon_Reload_Time, 1)
		set_upgrade_level(UpgradeType.Weapon_Next_Gun, 1)
		
		set_upgrade_level(UpgradeType.Ability_Bandaid, 0)
		set_upgrade_level(UpgradeType.Ability_Buckshot, 0)
		set_upgrade_level(UpgradeType.Ability_Bullet_Frenzy, 0)
		set_upgrade_level(UpgradeType.Ability_Coin_Multiplier, 0)
		set_upgrade_level(UpgradeType.Ability_Grenade_Throw, 0)
		set_upgrade_level(UpgradeType.Ability_Instant_Mine_Reload, 0)
		set_upgrade_level(UpgradeType.Ability_Stink_Candle, 0)
	
	func set_upgrade_level(stat: UpgradeType, level: int):
		_level_map[stat] = level
		
	func get_upgrade_level(stat: UpgradeType) -> int:
		return _level_map[stat]
		
	func _is_max_bulletcount_upgrade():
			return get_upgrade_level(UpgradeType.Weapon_Bullet_Count) == weapon_bullet_upgrade_data.size()
			
	func _is_max_bulletreload_upgrade():
			return get_upgrade_level(UpgradeType.Weapon_Reload_Time) == weapon_reload_upgrade_data.size()
	
	func get_upgrade_data(stat: UpgradeType) -> UpgradeData:
		var upgrade_data: UpgradeData = UpgradeData.new()
		
		upgrade_data.category = Upgrades._get_category_name(stat)
		upgrade_data.upgrade_name = Upgrades._get_stat_upgrade_name(stat)
		
		var stat_current_level: int = get_upgrade_level(stat)
		
		match stat:
			UpgradeType.Ship_Ship_HP:
				upgrade_data.cost = 100
				upgrade_data.level = 100
				
			UpgradeType.Player_Player_HP:
				upgrade_data.cost = 100
				upgrade_data.level = 100
				
			UpgradeType.Player_Player_Jumps:
				upgrade_data.cost = 100
				upgrade_data.level = 1
				
			UpgradeType.Player_Player_Speed:
				upgrade_data.cost = 100
				upgrade_data.level = 1
				
			UpgradeType.Weapon_Bullet_Count:
				if _is_max_bulletcount_upgrade():
					upgrade_data.no_more = true
				else:
					upgrade_data.cost = weapon_bullet_upgrade_data[stat_current_level]
				
			UpgradeType.Weapon_Reload_Time:
				if _is_max_bulletreload_upgrade():
					upgrade_data.no_more = true
				else:
					upgrade_data.cost = weapon_reload_upgrade_data[stat_current_level]
					
			UpgradeType.Weapon_Next_Gun:
				if _is_max_bulletcount_upgrade() and _is_max_bulletreload_upgrade():
					upgrade_data.cost = weapon_next_gun_data[stat_current_level]
				else:
					upgrade_data.unlocked = false

			UpgradeType.Roomba_Roomba_1:
				if stat_current_level > 0:
					upgrade_data.is_bought = true
				else:
					upgrade_data.cost = initial_costs[stat]
			UpgradeType.Roomba_Roomba_1_Speed:
				if get_upgrade_level(UpgradeType.Roomba_Roomba_1) > 0:
					upgrade_data.cost = _get_roombaspeed_cost(stat_current_level)
				else:
					upgrade_data.unlocked = false
					
			UpgradeType.Roomba_Roomba_2:
				if stat_current_level > 0:
					upgrade_data.is_bought = true
				else:
					upgrade_data.cost = initial_costs[stat]
			UpgradeType.Roomba_Roomba_2_Speed:
				if get_upgrade_level(UpgradeType.Roomba_Roomba_2) > 0:
					upgrade_data.cost = _get_roombaspeed_cost(stat_current_level)
				else:
					upgrade_data.unlocked = false
			UpgradeType.Roomba_Roomba_3:
				if stat_current_level > 0:
					upgrade_data.is_bought = true
				else:
					upgrade_data.cost = initial_costs[stat]
			UpgradeType.Roomba_Roomba_3_Speed:
				if get_upgrade_level(UpgradeType.Roomba_Roomba_3) > 0:
					upgrade_data.cost = _get_roombaspeed_cost(stat_current_level)
				else:
					upgrade_data.unlocked = false
		
			UpgradeType.CrowsNest_Nest_1:
				if stat_current_level > 0:
					upgrade_data.is_bought = true
				else:
					upgrade_data.cost = initial_costs[stat]
			UpgradeType.CrowsNest_Nest_1_Bullet_Damage:
				if get_upgrade_level(UpgradeType.CrowsNest_Nest_1) > 0:
					upgrade_data.cost = _get_nestdamage_cost(stat_current_level)
				else:
					upgrade_data.unlocked = false
			UpgradeType.CrowsNest_Nest_1_Reload_Time:
				if get_upgrade_level(UpgradeType.CrowsNest_Nest_1) > 0:
					upgrade_data.cost = _get_nestreload_cost(stat_current_level)
				else:
					upgrade_data.unlocked = false
			UpgradeType.CrowsNest_Nest_2:
				if stat_current_level > 0:
					upgrade_data.is_bought = true
				else:
					upgrade_data.cost = initial_costs[stat]
			UpgradeType.CrowsNest_Nest_2_Bullet_Damage:
				if get_upgrade_level(UpgradeType.CrowsNest_Nest_2) > 0:
					upgrade_data.cost = _get_nestdamage_cost(stat_current_level)
				else:
					upgrade_data.unlocked = false
			UpgradeType.CrowsNest_Nest_2_Reload_Time:
				if get_upgrade_level(UpgradeType.CrowsNest_Nest_2) > 0:
					upgrade_data.cost = _get_nestreload_cost(stat_current_level)
				else:
					upgrade_data.unlocked = false
					
			UpgradeType.Ability_Stink_Candle,UpgradeType.Ability_Bandaid,UpgradeType.Ability_Bullet_Frenzy,UpgradeType.Ability_Coin_Multiplier,UpgradeType.Ability_Instant_Mine_Reload,UpgradeType.Ability_Grenade_Throw,UpgradeType.Ability_Buckshot:
				upgrade_data.is_ability = true
				if stat_current_level > 0:
					upgrade_data.is_bought = true
				else:
					upgrade_data.cost = initial_costs[stat]
				
			UpgradeType.Traps_Water_Mine_1:
				upgrade_data.cost = _get_mine_cost(stat_current_level)
				
			UpgradeType.Traps_Water_Mine_2:
				upgrade_data.cost = _get_mine_cost(stat_current_level)
			
			_:
				push_error("yo fucked up yo, fucked. up. yo.")
		
		return upgrade_data
		
		




