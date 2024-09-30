extends AnimatedSprite2D

@onready var change_animation = $ChangeAnimation

var cur_animation : int = 0

var animation_dict : Dictionary = {
	1 : "charge2",
	2 : "charge3",
	3 : "charge4",
	4 : "charge5",
	5 : "full_charge"
	
}


func _on_change_animation_timeout():
	cur_animation += 1
	animation = animation_dict[cur_animation]
