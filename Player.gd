extends CharacterBody2D

var hp = 10000;
var speed = 1000;
var spell = "frost_rune"
var pr_abs = preload("res://projectile.tscn")

func _ready():
	pass

func _physics_process(delta):
	input_manager(delta)
	if hp < 1:
		death()
	
func input_manager(delta):
	if Input.is_action_just_pressed("attack"):
		var pr = pr_abs.instantiate()
		pr.init("frost", 1000, 1000, "frost", rotation, get_global_position(), "frost", 10, 10, "player")
		get_parent().add_child(pr)
	velocity = Vector2(0,0)
	if Input.is_action_pressed("left"):
		velocity.x = -1
	if Input.is_action_pressed("right"):
		velocity.x = +1
	if Input.is_action_pressed("up"):
		velocity.y = -1
	if Input.is_action_pressed("down"):
		velocity.y = +1
	velocity.normalized()
	move_and_collide(velocity*delta*speed)
	look_at(get_global_mouse_position())
	
func death():
	queue_free()
	
func status_report():
	if !$status_list.status_list.is_empty():
		print("----------------------------")
		for i in range(len($status_list.status_list)):
			print($status_list.status_list[i])

func per_second():
	status_report()
	$status_list.status()
