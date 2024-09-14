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
	button.text = str(upgrade_data.level - upgrade_data.old_level) + ", cost " + str(upgrade_data.cost) + " fish"
	
func _on_button_pressed():
	pass
