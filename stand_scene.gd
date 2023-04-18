extends Node2D

var area_abstract = preload("res://damage_area.tscn")


func _ready():
	var area_instance = area_abstract.instantiate()
	area_instance.init("frost", 10, 10)
	add_child(area_instance)
	$timer.start(1)


func _process(delta):
	pass


func _on_timer_timeout():
	for i in range(len(get_children())):
		if get_children()[i].name != "timer":
			get_children()[i].per_second()
	$timer.start(1)
