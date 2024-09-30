extends CharacterBody2D
class_name Snail

signal lose_game


@onready var check_top = $"Top"
@onready var check_bottom = $"Bottom"
@onready var detect_object = $DetectObject
@onready var timer = $Timer
@onready var raycast_array : Array[RayCast2D] = [$DetectObject, $DetectObject2, $DetectObject3, $DetectObject4, $DetectObject5]
@onready var area_2d = $AnimatedSprite2D/Area2D



@export var speed : int = 25
var cur_speed : int = 0
@export var vertical_speed : int = 25
var cur_vertical_speed : int = 0
var speed_max : int = 100
var _velocity = Vector2.ZERO
var _previous_speed : int = 0
var knockback_force = Vector2.ZERO
var vertical_weight : int = 0
var wait_for_speed_reset : bool = false

var game_over : bool = false


func _ready():
	cur_speed = speed
	cur_vertical_speed = vertical_speed
	timer.timeout.connect(add_new_ability)
	for node in raycast_array:
		node.object_collision.connect(establish_raycast_weight)




func _physics_process(delta):
	
	if wait_for_speed_reset:
		wait_for_speed_reset = false
		add_new_ability()
	
	if area_2d.has_overlapping_areas():
		what_areas_overlap()
	
	_velocity.x = cur_speed + knockback_force.x
	_velocity.y = 0
	
	var colliding = raycast_array.any(func(x : RayCast2D): return x.is_colliding())
	if colliding and _velocity.y == 0:
		_velocity.y = cur_vertical_speed if vertical_weight > 0 else cur_vertical_speed * -1
	
	
	#Force apply escape velocity away from walls
	if check_top.colliding():
		$Top.move_away()
		_velocity.y = cur_vertical_speed
	if check_bottom.colliding():
		$Bottom.move_away()
		_velocity.y = cur_vertical_speed * -1
	
	if !colliding:
		vertical_weight = 0
	
	velocity = _velocity
	move_and_slide()
	knockback_force = lerp(knockback_force, Vector2.ZERO, 0.1)


func check_raycasts() -> bool :
	for node in raycast_array:
		if node.is_colliding():
			return true
	return false


func establish_raycast_weight(weight : int):
	vertical_weight += weight


func what_areas_overlap() -> void:
	for node in area_2d.get_overlapping_areas():
		_on_area_2d_area_entered(node)


func turn_off_collision() -> void:
	area_2d.monitoring = false


func _on_area_2d_area_entered(area):
	
	if area.name == "LoseBarrier" and game_over == false:
		cur_speed = 0
		speed = 0
		game_over = true
		lose_game.emit()
		return
	
	if area.name == "LoseBarrier":
		return
	
	var trap = area.get_parent().item_resource
	
	match trap.item_effect:
		0:
			move_slow("start")
		1:
			move_stop("start")
		2:
			area.get_parent().queue_free()
			push_s("start", trap)
		3:
			area.get_parent().queue_free()
			push_h("start", trap)


func _on_area_2d_area_exited(area):
	
	if area.name == "LoseBarrier":
		return
	
	var trap = area.get_parent().item_resource
	
	match trap.item_effect:
		0:
			move_slow("end")
		1:
			move_stop("end")
		2:
			push_s("end", trap)
		3:
			push_h("end", trap)


func move_slow(timing : String) -> void:
	if timing == "start":
		if cur_speed != speed / 2:
			cur_speed = speed / 2
	else:
		cur_speed = speed
	print("Slow")


func move_stop(timing : String) -> void:
	if timing == "start":
		if cur_speed != -10:
			cur_speed = -10
			cur_vertical_speed = 0
	else:
		cur_speed = speed
		cur_vertical_speed = vertical_speed
	print("Stop")


func push_s(timing : String, trap : Item) -> void:
	var direction = Vector2.LEFT
	var force = direction * trap.knockback_strength
	knockback_force = force


func push_h(timing : String, trap : Item) -> void:
	var direction = Vector2.LEFT
	var force = direction * trap.knockback_strength
	knockback_force = force


func add_new_ability() -> void:
	if cur_speed == 0:
		return
	#Don't increase speed if we are currently affected by a trap
	#wait for the trap to leave the body before apply speed boost
	if cur_speed != speed:
		wait_for_speed_reset = true
		return
	
	if speed > speed_max:
		speed = speed_max
	else:
		speed += 15
	cur_speed = speed
