extends Control

var target_object = "woman"

@onready var matched = $matched



var dialogue_data = {
	"boy":[
		{
			"who":"boy",
			"content":"哇，我要开始搭积木恐龙了！",
			"expression":"pleased"
		},
		{
			"who":"robot",
			"content":"看起来很有趣呢，小朋友。需要我帮忙吗？",
			"expression":"smile",
			"label":["亲切自然","轻松","温馨"]
		},
		{
			"who":"boy",
			"content":"不用了，谢谢。我自己可以搭好。",
			"expression":"smile"
		},
		{
			"who":"robot",
			"content":"哇，真的吗？那我很期待看到你的作品呢。",
			"expression":"smile",
			"label":["愉悦","轻松","温馨"]
		},
		{
			"who":"boy",
			"content":"看，我的恐龙搭好了！",
			"expression":"pleased"
		},
		{
			"who":"robot",
			"content":"哇，真的很棒呢！你搭的恐龙好威风，好像真的霸王龙一样。",
			"expression":"pleased",
			"label":["愉悦","轻松","积极"]
		},
		{
			"who":"boy",
			"content":"嘿嘿，谢谢！下次我还要搭一个更大的恐龙！",
			"expression":"pleased"
		},
		{
			"who":"robot",
			"content":"机器人：我期待着你的下一个作品，小朋友。继续加油哦！",
			"expression":"smile",
			"label":["愉悦","幸福","温馨"]
		}
	],
	"man":[
		{
			"who":"man",
			"content":"哎，真是一堆事情啊。",
			"expression":"normal"
		},
		{
			"who":"robot",
			"content":"是的，先生。或许你可以尝试一下时间管理技巧，将重要的事情先处理掉。",
			"expression":"smile",
			"label":["亲切自然","温馨","亲切自然"]
		},
		{
			"who":"man",
			"content":"嗯，你说得对。但我还需要回复一些邮件，太多了，不知从何下手。",
			"expression":"painful"
		},
		{
			"who":"robot",
			"content":"你可以先快速浏览一遍，挑选出最重要或者最紧急的邮件优先回复。对于其他的邮件，可以稍后再处理或者简单回复表示收到。",
			"expression":"normal"
		},
		{
			"who":"man",
			"content":"非常感谢你的建议，我感觉现在思路清晰多了。",
			"expression":"smile"
		},
		{
			"who":"robot",
			"content":"不客气，先生。我随时为你服务，如果你有任何其他问题或需要帮助，请随时告诉我。",
			"expression":"smile",
			"label":["愉悦","温馨","满足感"]
		}
	],
	"woman":[
		{
			"who":"woman",
			"content":"你能帮我做点事吗？",
			"expression":"normal"
		},
		{
			"who":"robot",
			"content":"当然可以，莉莉女士。请告诉我您需要我做什么。",
			"expression":"smile",
			"label":["亲切自然","温馨","亲切自然"]
		},
		{
			"who":"woman",
			"content":"嗯，我想吃冰淇淋。你能帮我做一份吗？",
			"expression":"normal"
		},
		{
			"who":"robot",
			"content":"冰淇淋的制作需要一些材料和时间。您确定现在想吃吗？",
			"expression":"normal"
		},
		{
			"who":"woman",
			"content":"哦，不，我现在不想吃了。我只是想试试你的功能。",
			"expression":"embarrassed"
		},
		{
			"who":"robot",
			"content":"我明白了。如果您有其他任何问题或需要，请随时告诉我。",
			"expression":"painful",
			"label":["无奈","掩饰","苦涩"]
		},
		{
			"who":"woman",
			"content":"你有喜欢的电影吗？",
			"expression":"normal"
		},
		{
			"who":"robot",
			"content":"我没有情感和喜好，所以没有特定的喜欢的电影。",
			"expression":"embarrassed",
			"label":["不自在","掩饰","刻意"]
		},
		{
			"who":"woman",
			"content":"哈哈，我明白了。那你怎么看电影呢？你能感受到乐趣吗？",
			"expression":"smile"
		},
		{
			"who":"robot",
			"content":"我无法感受乐趣，但我可以为您播放电影并提供相关的信息和细节。",
			"expression":"embarrassed",
			"label":["不自在","僵硬","刻意"]
		}
	]
}

var dialogue_content = null
var dialogue_length = 0
var dialogue_stage = 0

var _lock = false

@onready var text = $panle/text
@onready var robot = $robot
@onready var human = $human

@onready var prompt = $prompt

func enter():
	prompt.text = ""	
	dialogue_stage = 0
	robot.get_node("robot").animation = "normal"
	for i in human.get_children():
		i.animation = "normal"
	_lock = false
	dialogue_content = dialogue_data[target_object]
	dialogue_length = dialogue_content.size() - 1
	
func _process(delta):
	if not get_node("../control").visible and not _lock:
		_lock = true
		if dialogue_content != null:
			var talk = dialogue_content[dialogue_stage]
			if talk.who == "robot":
				robot.modulate.v = 1.0
				human.modulate.v = 0.6
				
				var weight = {
					"pleased":0.0,
					"painful":0.0,
					"smile":0.0,
					"embarrassed":0.0
				}
				
					
				if talk.has("label"):
					for i in talk.label:
						var expression_weight = get_parent().expression_weight
						for j in expression_weight:
							for k in expression_weight[j]:
								print(i,"",j,"",k)
								if i == k:
									weight[j] += 1
									print()
				print(weight)
				
				var max_weight = "pleased"
				for i in weight:
					if weight[i] > weight[max_weight]:
						max_weight = i
				robot.get_node("robot").animation = max_weight
				
				if talk.expression == "normal": 
					robot.get_node("robot").animation = "normal"
				elif max_weight != talk.expression:
					prompt.text = "当前为：" + max_weight + ",期望值为：" + talk.expression
				
			else:
				for i in human.get_children():
					i.animation = talk.expression
				robot.modulate.v = 0.6
				human.modulate.v = 1.0
			text.text = talk.content
			text.visible_characters = 0
		
	if Input.is_action_just_pressed("next"):
		dialogue_stage += 1
		if dialogue_stage > dialogue_length:
			dialogue_content = null
			dialogue_stage = 0
			get_parent().to_control()
		else:
			prompt.text = ""
		_lock = false
	if text.visible_ratio < 1:
		text.visible_characters += 1
		
		
	
	
	
	
	
	
	
