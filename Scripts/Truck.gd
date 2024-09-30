extends AnimatedSprite2D

@onready var change_animation = $ChangeAnimation
@onready var boost_sound = $BoostSound

var cur_animation : int = 0

var animation_dict : Dictionary = {
	1 : "charge2",
	2 : "charge3",
	3 : "charge4",
	4 : "charge5",
	5 : "full_charge"
	
}

func _ready():
	$EngineRumble.finished.connect(restart_engine_audio)


func restart_engine_audio() -> void:
	$EngineRumble.play(0.0)


func _on_change_animation_timeout():
	cur_animation += 1
	if cur_animation > animation_dict.size():
		return
	animation = animation_dict[cur_animation]
	boost_sound.play()
