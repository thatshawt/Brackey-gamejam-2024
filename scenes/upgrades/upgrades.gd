extends Control

@onready
var upgrades_vcontainer = $MarginContainer/VBoxContainer/upgradesScrollContainer/theUpgradesVerticalContainer

@onready
var categoryVbox = $MarginContainer2/leftvbox
# there is no bad only good and bad enough

@onready
var LeftButton = load("res://scenes/upgrades/leftbutton.tscn")

@onready var RightThing = load("res://scenes/upgrades/upgradeContainer.tscn")
var categories_added = []

func _ready():
	SignalBus.ui_change_category.connect(on_ui_catgeory_change)
	SignalBus.ui_buy_level.connect(on_ui_buy_level)
	
	for upgrade in Upgrades.UpgradeType.values():
		var category_name = Upgrades._get_category_name(upgrade)
		if not categories_added.has(category_name):
			categories_added.append(category_name)
			
			var button_thing: LeftGoddamButtonType = LeftButton.instantiate()
			#print(button_thing)
			button_thing.set_categoryu(category_name)
			
			categoryVbox.add_child(button_thing)

func on_ui_catgeory_change(category: String):
	for n in upgrades_vcontainer.get_children():
		upgrades_vcontainer.remove_child(n)
		n.queue_free()

	for upgrade in Upgrades.UpgradeType.values():
		var category_name = Upgrades._get_category_name(upgrade)
		
		if category_name == category:
			
			var right: RightGoddamnContainer = RightThing.instantiate()
			upgrades_vcontainer.add_child(right)
			right.set_upgrade_data(GlobalScript.game_state.upgrades_state.get_upgrade_data(upgrade))
			
func on_ui_buy_level(upgrade: Upgrades.UpgradeData):
	on_ui_catgeory_change(upgrade.category)
