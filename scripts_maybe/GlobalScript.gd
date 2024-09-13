extends Node

class Ability:
	var cooldown: int = 0

class Hotbar:
	#var weapon: Weapon = null
	var ability1: Ability = null
	var ability2: Ability = null

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
	var fish: int = 0
	
	var hotbar: Hotbar = GlobalScript.Hotbar.new()
	var ship_state: ShipState = GlobalScript.ShipState.new()
	var wave_state: WavesState = GlobalScript.WavesState.new()
	
	func _init():
		pass

var game_state = GlobalScript.GameState.new()

func _ready():
	pass
	
	
