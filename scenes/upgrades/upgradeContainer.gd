extends HBoxContainer

class_name RightGoddamnContainer

var upgrade_data: Upgrades.UpgradeData

@onready var label_left = $Label
@onready var label_right = $Label2
@onready var button = $Button

# i forgot waht the sigma i was doing

func set_upgrade_data(upgrade_data: Upgrades.UpgradeData):
	self.upgrade_data = upgrade_data
	# +10, cost 1 fish
	label_left.text = str(self.upgrade_data.upgrade_name)
	label_right.text = str(self.upgrade_data.old_level)
	button.text = str(upgrade_data.level) + ", cost " + str(upgrade_data.cost) + " fish"
	
func _on_button_pressed():
	var upgrade_state = GlobalScript.game_state.upgrades_state
	var fish = GlobalScript.game_state.fish
	var cost = upgrade_data.cost
	var levels = upgrade_data.level
	
	if fish >= cost:
		upgrade_state.increment_upgrade_level(upgrade_data.stat, levels)
		GlobalScript.game_state.fish = fish - cost
		
		SignalBus.ui_buy_level.emit(upgrade_data)
