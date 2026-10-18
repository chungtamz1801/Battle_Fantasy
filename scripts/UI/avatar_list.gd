extends ScrollContainer

var avatar_data: Array[AvatarData]
var stat_labels: Array[Button]
var stat_names := ["HP","ATK","DEF","MAG","RES","MP","SPD","CRIT","MRG"]
@onready var avatar_selection = get_tree().current_scene
@onready var avatar_name_label := $"../AvatarInfo/AvatarName"
@onready var avatar_image = $"../AvatarInfo/AvatarImage"
@onready var skill_list_container = $"../TagExpandationList/SkillContainer/SkillList"
@onready var passive_list_container = $"../TagExpandationList/PassiveContainer/PassiveList"
@onready var avatar_list_container = $AvatarList

func _ready() -> void:
	avatar_data = AvatarRepo.avatar_data
	avatar_selection.avatar_changed.connect(_on_player_selected)
	load_stat_labels()
	load_avatar_buttons()

func load_stat_labels():
	for i in range(5):
		stat_labels.append(get_node("../AvatarInfo/AvatarStat/LeftStat/%sPoints" % stat_names[i]))
		stat_labels.append(get_node("../AvatarInfo/AvatarStat/LeftStat/%sScale" % stat_names[i]))
		stat_labels.append(get_node("../AvatarInfo/AvatarStat/LeftStat/%sStat" % stat_names[i]))
	for i in range(4):
		stat_labels.append(get_node("../AvatarInfo/AvatarStat/RightStat/%sPoints" % stat_names[i+5]))
		stat_labels.append(get_node("../AvatarInfo/AvatarStat/RightStat/%sScale" % stat_names[i+5]))
		stat_labels.append(get_node("../AvatarInfo/AvatarStat/RightStat/%sStat" % stat_names[i+5]))

func _on_button_pressed(data: AvatarData) -> void:
	avatar_selection.set_avatar(data.Name)
	load_skill_list(data.Skills)
	load_passive_list(data.Passives)

func _on_player_selected(avatar_id: String):
	for data in avatar_data:
		if data.Name == avatar_id:
			set_avatar_UI(data)
			break
		else:
			clear_avatar_UI()

func set_avatar_UI(data: AvatarData):
	avatar_name_label.text = data.Name
	avatar_image.texture = load("res://sprites/avatars/%s.png" % data.Name)
	for i in range(stat_names.size()):
		var avatar_stat:Stat = data.get(stat_names[i])
		stat_labels[i*3].text = str(avatar_stat.points)
		stat_labels[i*3+1].text = str(avatar_stat.scale)
		stat_labels[i*3+2].text = str(avatar_stat.points * avatar_stat.scale)

func load_avatar_buttons():
	for data in avatar_data:
		avatar_list_container.add_child(create_button_for_container(data.Name, _on_button_pressed.bind(data)))

func load_skill_list(skills:Array[String]):
	for child in skill_list_container.get_children():
		child.queue_free()
		
	for skill in skills:
		skill_list_container.add_child(create_button_for_container(skill,Callable(),true))

func load_passive_list(passives:Array[String]):
	for child in passive_list_container.get_children():
		child.queue_free()
		
	for passive in passives:
		passive_list_container.add_child(create_button_for_container(passive,Callable(),true))

func create_button_for_container(text:String, on_pressed: Callable, isDisable:bool = false) -> Button:
	var new_button = Button.new()
	new_button.alignment = HORIZONTAL_ALIGNMENT_LEFT
	new_button.text = text
	new_button.custom_minimum_size.y = 50
	new_button.set_anchors_preset(Control.PRESET_TOP_WIDE)
	if not on_pressed.is_null():
		new_button.pressed.connect(on_pressed)
	var style_box:StyleBox = new_button.get_theme_stylebox("normal").duplicate()
	style_box.content_margin_left = 15
	new_button.add_theme_stylebox_override("normal",style_box)
	if(isDisable):
		new_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return new_button

func clear_avatar_UI():
	avatar_name_label.text = ""
	avatar_image.texture = null
	for label in stat_labels:
		label.text = ""
