extends Button

class_name LeftGoddamButtonType

var category: String

func _init(category: String):
	self.category = category
	self.text = category
	
	
func _on_pressed():
	SignalBus.ui_change_category.emit(self.category)
