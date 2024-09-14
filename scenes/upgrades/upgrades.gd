extends Control

@onready
var upgrades_vcontainer = $MarginContainer/VBoxContainer/upgradesScrollContainer/theUpgradesVerticalContainer

@onready
var categoryVbox = $MarginContainer2/leftvbox
# there is no bad only good and bad enough

var LeftButton = load("res://scenes/upgrades/leftbutton.tscn")

var categories_added = []

func _ready():
	SignalBus.ui_change_category.connect(on_ui_catgeory_change)
	
	for upgrade in Upgrades.UpgradeType.values():
		var category_name = Upgrades._get_category_name(upgrade)
		if not categories_added.has(category_name):
			categories_added.append(category_name)
			
			var button_thing: LeftGoddamButtonType = LeftButton.instantiate()
			button_thing.category = category_name
			
			categoryVbox.add_child(button_thing)

func on_ui_catgeory_change(category: String):
	pass
