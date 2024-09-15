extends Label

func _ready():
	SignalBus.ui_update_hotbar.connect(update)
	
func update():
	var hotbar = GlobalScript.game_state.hotbar
	#self.text = "Weapon: " + hotbar.weapon.weapon_name + " , ability1: " + hotbar.ability1.ability_name + " ability2: " + hotbar.ability1.ability_name
