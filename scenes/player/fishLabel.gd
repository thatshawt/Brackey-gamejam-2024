extends Label

func _ready():
	SignalBus.ui_update_fish.connect(update)
	
func update():
	self.text = "fish: " + str(GlobalScript.game_state.fish)
