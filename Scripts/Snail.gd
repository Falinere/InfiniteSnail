extends CharacterBody2D

@onready var check_top = $"Top"
@onready var check_bottom = $"Bottom"
@onready var detect_object = $DetectObject
@onready var timer = $Timer
@onready var raycast_array : Array[RayCast2D] = [$DetectObject, $DetectObject2, $DetectObject3, $DetectObject4, $DetectObject5]


@export var speed : int = 10
var vertical_speed : int = 35
var speed_min : int = 10
var speed_max : int = 50

var _velocity = Vector2.ZERO
var _previous_speed : int = 0

var knockback_force = Vector2.ZERO

var vertical_weight : int = 0

func _ready():
	timer.timeout.connect(add_new_ability)
	for node in raycast_array:
		node.object_collision.connect(establish_raycast_weight)




func _physics_process(delta):
	
	_velocity.x = speed + knockback_force.x
	_velocity.y = 0
	
	var colliding = raycast_array.any(func(x : RayCast2D): return x.is_colliding())
	if colliding and _velocity.y == 0:
		_velocity.y = vertical_speed if vertical_weight > 0 else vertical_speed * -1
	
	if colliding:
		velocity = _velocity
		move_and_slide()
		knockback_force = lerp(knockback_force, Vector2.ZERO, 0.1)
		return
	else:
		vertical_weight = 0
	
	#Force apply escape velocity away from walls
	if check_top.colliding():
		print("Colliding On Top")
		$Top.move_away()
		_velocity.y = vertical_speed
	#else:
		#$Top.reset()
	if check_bottom.colliding():
		print("Colliding On Bottom")
		$Bottom.move_away()
		_velocity.y = vertical_speed * -1
	#else:
		#$Bottom.reset()
	
	
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


func _on_area_2d_area_entered(area):
	var trap = area.get_parent().item_resource
	
	match trap.item_effect:
		0:
			move_slow("start")
		1:
			move_stop("start")
		2:
			for child in area.get_children():
				child.queue_free()
			push_s("start", trap)
		3:
			for child in area.get_children():
				child.queue_free()
			push_h("start", trap)


func _on_area_2d_area_exited(area):
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
		speed /= 2
	else:
		speed *= 2
	print("Slow")


func move_stop(timing : String) -> void:
	if timing == "start":
		_previous_speed = speed
		speed = 0
	else:
		speed = _previous_speed
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
	#speed += 10
	if speed > speed_max:
		speed = speed_max
