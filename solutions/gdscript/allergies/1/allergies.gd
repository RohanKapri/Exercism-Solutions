@export var score : int
@export var lst: Array: get = _get_lst

var ALLERGENS = ["eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats"]


func allergic_to(item):
	return 1 << ALLERGENS.find(item) & score != 0


func _get_lst() -> Array:
	var out = []
	for i in ALLERGENS:
		if allergic_to(i):
			out.append(i)
	return out