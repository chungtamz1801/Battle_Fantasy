extends ScrollContainer

var avatar_data: Array[AvatarData]
@onready var avatar_selection = get_tree().current_scene
@onready var avatar_name_label := $"../AvatarInfo/AvatarName"
@onready var avatar_image = $"../AvatarInfo/AvatarImage"
@onready var avatar_left_stat_label = $"../AvatarInfo/AvatarStat/LeftStat"
@onready var avatar_right_stat_label = $"../AvatarInfo/AvatarStat/RightStat"
@onready var skill_list_container = $"../TagExpandationList/SkillContainer/SkillList"
@onready var passive_list_container = $"../TagExpandationList/PassiveContainer/PassiveList"
@onready var avatar_list_container = $AvatarList

func _ready() -> void:
	avatar_data = AvatarRepo.avatar_data
	avatar_selection.avatar_changed.connect(_on_player_selected)
	load_avatar_buttons()

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
	avatar_left_stat_label.text = """
HP: %d x %d = %d \n
ATK: %d x %d = %d \n
DEF: %d x %d = %d \n
MAG: %d x %d = %d \n
RES: %d x %d = %d \n""" % [
		data.HP.points,
		data.HP.scale,
		data.HP.points*data.HP.scale,
		data.ATK.points,
		data.ATK.scale,
		data.ATK.points*data.HP.scale,
		data.DEF.points,
		data.DEF.scale,
		data.DEF.points*data.HP.scale,
		data.MAG.points,
		data.MAG.scale,
		data.MAG.points*data.HP.scale,
		data.RES.points,
		data.RES.scale,
		data.RES.points*data.HP.scale,
	]
	
	avatar_right_stat_label.text = """
MP: %d x %d = %d \n
SPD: %d x %d = %d \n
CRIT: %d x %d = %d \n
MRG: %d x %d = %d \n
N.Attack: %s \n""" % [
		data.MP.points,
		data.MP.scale,
		data.MP.points*data.HP.scale,
		data.SPD.points,
		data.SPD.scale,
		data.SPD.points*data.HP.scale,
		data.CRIT.points,
		data.CRIT.scale,
		data.CRIT.points*data.HP.scale,
		data.MRG.points,
		data.MRG.scale,
		data.MRG.points*data.HP.scale,
		data.Normal_Attack
	]

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
	avatar_left_stat_label.text = ""
	avatar_right_stat_label.text = ""	
