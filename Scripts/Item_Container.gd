extends HBoxContainer

@export var item_total : int = 0


func update_ui() -> void:
	item_total += 1
	
	if item_total > 4:
		return
	
	var item_str : String = str(item_total)
	get_node(item_str).setup(item_total)
	get_node(item_str)
	get_node(item_str).visible = true


func item_used(item_number : int) -> void:
	get_node(str(item_number)).fade_out()
