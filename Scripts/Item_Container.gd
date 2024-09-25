extends HBoxContainer

@export var item_total : int = 0


func update_ui() -> void:
	item_total += 1
	var item_str : String = str(item_total)
	get_node(item_str).setup()
	get_node(item_str).visible = true
