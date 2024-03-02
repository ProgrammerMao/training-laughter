extends Node

@onready var transform = $transform

@onready var dialogue = $dialogue
@onready var control = $control 

#var matching_degree = {
	#"boy":-1.0,
	#"man":-1.0,
	#"woman":-1.0
#}

var debug = false

var is_dialogue = false

var expression_weight = {
	"pleased":["愉悦","轻松","积极"],
	"painful":["无奈","掩饰","苦涩"],
	"smile":["愉悦","轻松","温馨","亲切自然","幸福","成就感"],
	"embarrassed":["不自然","掩饰","不自在","僵硬","刻意"]
}

#var err_message = {
	#"boy"
#}

func to_dialogue(who:String):
	dialogue.target_object = who
	var backimage = $dialogue/backimage.texture
	if who == "boy":
		$dialogue/backimage.texture = preload("res://images/background/bedroom.jpg")
	if who == "man":
		$dialogue/backimage.texture = preload("res://images/background/study.jpg")
	if who == "woman":
		$dialogue/backimage.texture = preload("res://images/background/parlor.jpg")
	
	for i in dialogue.get_node("human").get_children():
		if i.name == who:
			i.visible = true
		else:
			i.visible = false	
		
	transform.play_backwards("transform")
	is_dialogue = true

func to_control():
	transform.play_backwards("transform")
	is_dialogue = false

func _on_transform_animation_finished(anim_name):
	if transform.get_node("transform").modulate.a > 0:
		if is_dialogue:
			dialogue.visible = true
			control.visible = false
		else:
			dialogue.visible = false
			control.visible = true
		transform.play("transform")
	else:
		if is_dialogue:
			dialogue.enter()
		
		
		
		
