extends Resource
class_name Item

@export var name : String = ""
@export var key : int
@export var offset : Vector2
@export_enum("Slow", "Stop", "Pushback S", "Pushback H") var item_effect 
@export var knockback_strength : int = 0
@export var max_uses : int = 0
@export var cooldown_value : int = 0
@export_group("Textures")
@export var texture : Texture2D
@export var ui_texture : Texture2D
@export_group("Collision Shapes")
@export var shape_2d : Shape2D
@export var polygon_2d : PackedVector2Array


# Spike Trap - Stop
# Spinning Blade - Pushback - Little
# Acme Cartoon Bomb - Pushback - Heavy
# Salt Pile - Slow
