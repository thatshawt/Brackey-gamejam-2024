extends Button

@onready var canvas_layer = $".."

@onready var Upgrades = load("res://scenes/upgrades/upgrades.tscn")

var thing

var upgrades_on_screen = false

func _on_pressed():
	if upgrades_on_screen:
		
		#print("what th sigma")
		
		canvas_layer.remove_child(thing)
		thing.queue_free()
		upgrades_on_screen = false
	else:
		var upgrades_ui_container = Upgrades.instantiate()
		
		canvas_layer.add_child(upgrades_ui_container)
		
		thing = upgrades_ui_container
		upgrades_on_screen = true

