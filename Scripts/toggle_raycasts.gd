extends Node2D

func move_away():
	
	get_node("1").enabled = true
	get_node("2").enabled = true


func reset():
	get_node("1").enabled = true
	get_node("2").enabled = false


func _physics_process(delta):
	if !colliding():
		reset()
	#if get_node("1").is_colliding():
		#get_node("2").enabled = true
	##if get_node("2").enabled and !get_node("2").is_colliding():
		##get_node("2").enabled = false
		##get_node("1").enabled = true


func colliding() -> bool:
	for node in get_children():
		if node.is_colliding():
			return true
	return false
	#return get_node(node).is_colliding()
