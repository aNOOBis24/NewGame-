extends RigidBody2D
 
var damage_type: String
var speed: int
var range: int
var element: String
var direction: float
var start_position: Vector2
var spell_type: String
var spell_radius: int
var spell_lifetime: int
var velocity = Vector2(0,0)
var master: String

var area_abstract = preload("res://damage_area.tscn")

func init(n_damage_type: String, n_speed: int, n_range: int, n_element: String, n_direction: float, n_start_position: Vector2, n_spell_type: String, n_spell_radius: int, n_spell_lifetime: int, n_master: String):
	damage_type = n_damage_type
	speed = n_speed
	range = n_range
	element = n_element
	direction = n_direction
	start_position = n_start_position
	spell_type = n_spell_type
	spell_radius = n_spell_radius
	spell_lifetime = n_spell_lifetime
	master = n_master
	
func _ready():
	position = start_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	velocity = Vector2(speed, 0).normalized()
	if start_position.distance_to(position) <= range:
		cast(delta)
	else:
		following_cast(damage_type, spell_lifetime, spell_radius)
		queue_free()

func cast(delta):
	if spell_type != "none":
		velocity = Vector2(speed, 0).rotated(direction).normalized()
		move_and_collide(velocity * speed * delta )

func following_cast(damage_type, spell_lifetime, spell_radius):
	var area_instance = area_abstract.instantiate()
	area_instance.init(damage_type, spell_lifetime, spell_radius)
	area_instance.position = get_global_position()
	get_parent().add_child(area_instance)
	print("Создана руна")

func per_second():
	pass


func _on_projectile_hitbox_body_entered(body):
	if body.name != master and body.name != "projectile" and body.name != "damage_area":
		print(body.name)
		following_cast(damage_type, spell_lifetime, spell_radius)
		queue_free()
