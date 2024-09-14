extends Button

class_name LeftGoddamButtonType

var category: String

func set_categoryu(cate: String):
	self.category = cate
	self.text = category
	
func _on_pressed():
	SignalBus.ui_change_category.emit(self.category)
