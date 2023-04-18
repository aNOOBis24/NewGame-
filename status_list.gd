extends Node

var status_list = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	pass

func status():
	if status_list.is_empty() == false:
		for i in range(status_list.size()):
			if !status_list[i][2]:
				status_list[i][2] = true
			elif status_list[i][1] == null:
				call(status_list[i][0])
			elif status_list[i][2] and status_list[i][1] >= 1:
				status_list[i][1] -= 1
				call(status_list[i][0])
			elif status_list[i][2] and status_list[i][1] < 1:
				status_list.remove_at(i)
				return

func fire():
	if status_list[status_list.find("fire")][1] == null:
		get_parent().hp -= 3
	elif (status_list[status_list.find("fire")][1] > 0):
		get_parent().hp -= 3

func frost():
	if status_list[status_list.find("frost")][1] == null:
		get_parent().hp -= 1
	elif (status_list[status_list.find("frost")][1] > 0):
		get_parent().hp -= 1

func has_element(element):
	for i in range(len(status_list)):
		if status_list[i].has(element):
			return true
	return false

func get_status_list():
	return status_list

func find_part_adress(element):
	for i in range(len(status_list)):
		for j in range(len(status_list[i])):
			if status_list[i][j] == element:
				return i;

func find_full_adress(element):
	for i in range(len(status_list)):
		for j in range(len(status_list[i])):
			if status_list[i][j] == element:
				return [i,j]

func set_value(index_i, index_j, element):
	status_list[index_i][index_j] = element

func add(element):
	status_list.append(element)

func remove_status(element):
	status_list.remove_at(find_part_adress(element))
