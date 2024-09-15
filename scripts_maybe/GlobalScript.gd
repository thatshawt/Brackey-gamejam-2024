extends Node

class_name GlobalScriptType

# Imports
#var Weapon = preload("res://scenes/weapon/weapon.gd")

class Ability:
	var cooldown: int = 0
	var ability_name: String

class Hotbar:
	var weapon: Weapon
	var ability1: Ability
	var ability2: Ability

class WavesState:
	var current_wave: int = 0

class ShipState:
	var max_hp: float = 100.0
	var hp: float = 100.0
	
	func _init():
		SignalBus.ship_damage_hp.connect(on_ship_dmg)
		
	func on_ship_dmg(dmg_amount: float):
			hp = hp - dmg_amount
			
			if hp <= 0.0:
				SignalBus.game_lose.emit()

class GameState:
	var fish: int = 1000
	
	var hotbar: Hotbar = GlobalScriptType.Hotbar.new()
	var ship_state: ShipState = GlobalScriptType.ShipState.new()
	var wave_state: WavesState = GlobalScriptType.WavesState.new()
	
	var upgrades_state: Upgrades.UpgradesState = Upgrades.UpgradesState.new()
	
	var the_player: PlayerNode

	func _init():
		pass
		
	func weapon_change():
		pass


# in the heavens and earth, i alone am the stateful one
@onready
var game_state: GameState = GlobalScriptType.GameState.new()

func _ready():
	print(game_state)
	#SignalBus.weapon_change.connect(game_state.weapon_change)
	#SignalBus.weapon_change.emit(Weapon.weapons.Bow)
	
	game_state.upgrades_state.get_upgrade_data(Upgrades.UpgradeType.Weapon_Bullet_Count)
	
	#SignalBus.stat_set_level.connect(game_state.on_stat_level_set)

# game_state.stats[Stats.SHIP_HP].upgrade()
# game_state.stats[Stats.SHIP_HP].get()

# game_state.upgrade_stat(Stats.SHIP_HP)
