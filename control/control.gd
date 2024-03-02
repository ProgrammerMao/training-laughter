extends Control


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_edit_text_changed(new_text):
	for i in $keyword.get_children():
		if i.name != "title" or i.name != "backcolor" and get_parent().debug:
			if i .name == "pleased":
				get_parent().expression_weight.pleased = i.get_node("edit").text.split(" ")
			if i .name == "painful":
				get_parent().expression_weight.painful = i.get_node("edit").text.split(" ")
			if i .name == "smile":
				get_parent().expression_weight.smile = i.get_node("edit").text.split(" ")
			if i .name == "embarrassed":
				get_parent().expression_weight.embarrassed = i.get_node("edit").text.split(" ")




func _on_boy_pressed():
	get_parent().to_dialogue("boy")


func _on_woman_pressed():
	get_parent().to_dialogue("woman")


func _on_man_pressed():
	get_parent().to_dialogue("man")
