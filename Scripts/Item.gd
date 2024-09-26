extends Resource
class_name Item


@export var name : String = ""
@export var texture : Texture2D
@export var key : int
@export var shape_2d : Shape2D
@export var polygon_2d : PackedVector2Array
@export var ui_texture : Texture2D
@export_enum("Slow", "Stop", "Pushback S", "Pushback H") var item_effect 
@export var knockback_strength : int = 0


# Spike Trap - Stop
# Spinning Blade - Pushback - Little
# Acme Cartoon Bomb - Pushback - Heavy
# Salt Pile - Slow
