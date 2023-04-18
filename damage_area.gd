extends Area2D

class_name damage_area

var area_type: String

var lifetime = 100

var radius = 1000

func init(n_area_type:String, n_lifetime: int, n_radius: int):
	area_type = n_area_type
	lifetime = n_lifetime
	radius = n_radius

func _ready():
	$shape.shape.radius = radius
	$frost_sprite.scale = Vector2(radius*0.0333, radius*0.0333)
	$fire_sprite.scale = Vector2(radius*0.0333, radius*0.0333)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if area_type == "fire":
		$fire_sprite.visible = true
		$frost_sprite.visible = false
	if area_type == "frost":
		$frost_sprite.visible = true
		$fire_sprite.visible = false



func _on_body_entered(body):
		if !body.get_node("status_list").has_element(area_type):
			body.get_node("status_list").add([area_type, null, false])
		else:
			body.get_node("status_list").set_value(body.get_node("status_list").find_part_adress(area_type), 1, null)



func _on_body_exited(body):
		if body.get_node("status_list").has_element(area_type):
			body.get_node("status_list").remove_status(area_type)
		body.get_node("status_list").add([area_type, 5, false])
	
func lifetime_spending():
	lifetime -= 1
	if lifetime < 1:
		queue_free()

func per_second():
	lifetime_spending()
