extends CharacterBody2D

#var target = get_parent().get_node($player)
var hp = 10
var speed = 200

func _physics_process(delta):
	_attack(get_parent().get_node("player"), delta)
	if hp <= 0:
		death()
	
func _attack(target, delta):
	velocity = (target.position - position).normalized()
	#print(str(target.position) + " Target Position ")
	#rotate(get_angle_to(target.position))
	look_at(target.position)
	move_and_collide(velocity * speed * delta)

func death():
	queue_free()

func per_second():
#	status_report()
	$status_list.status()
