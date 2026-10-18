extends Node

var avatar_data: Array[AvatarData]
var scale_data: Array
var avatar_path := "res://data/avatars.json"
var scale_path := "res://data/scales.json"
var skill_tag_path := "res://data/skill_tags.json"
var passive_tag_path := "res://data/passive_tags.json"

@onready var raw_skill_tag_data := read_data_from_file("res://data/skill_tags.json")
@onready var raw_passive_tag_data := read_data_from_file("res://data/passive_tags.json")

func _ready():
	load_scale_data()
	load_avatar_data()
	
func load_avatar_data():
	for data in read_data_from_file(avatar_path):
		avatar_data.append(from_dict(data))

func load_scale_data():
	scale_data = read_data_from_file(scale_path)

func from_dict(data: Dictionary) -> AvatarData:
	var avatar := AvatarData.new()
	var scale
	for sdata in scale_data:
		if sdata["id"] == data.get("Scale","default"):
			scale = sdata
			break
	
	avatar.Name = data.get("Name", "")
	avatar.HP = get_stat(data.get("HP",0),"HP",scale)
	avatar.ATK = get_stat(data.get("ATK",0),"ATK",scale)
	avatar.DEF = get_stat(data.get("DEF",0),"DEF",scale)
	avatar.MAG = get_stat(data.get("MAG",0),"MAG",scale)
	avatar.RES = get_stat(data.get("RES",0),"RES",scale)
	avatar.SPD = get_stat(data.get("SPD",0),"SPD",scale)
	avatar.MP = get_stat(data.get("MP",0),"MP",scale)
	avatar.MRG = get_stat(data.get("MRG",0),"MRG",scale)
	avatar.CRIT = get_stat(data.get("CRIT",0),"CRIT",scale)

	avatar.Normal_Attack = data.get("Normal Attack", "")

	avatar.Skills = get_skills_from_tags(data.get("Tag",[]))
	avatar.Passives = get_passives_from_tags(data.get("Tag",[]))

	return avatar	
	
func get_skills_from_tags(tags: Array) -> Array:
	var skill_list: Array[String]
	for tag in tags:
		for temp_tag in raw_skill_tag_data:
			if temp_tag["id"] == tag:
				skill_list.append_array(temp_tag["skills"])
				break
	return skill_list
	
func get_passives_from_tags(tags: Array) -> Array:
	var passive_list: Array[String]
	for tag in tags:
		for temp_tag in raw_passive_tag_data:
			if temp_tag["id"] == tag:
				passive_list.append_array(temp_tag["passives"])
				break
	return passive_list
	
func read_data_from_file(path: String) -> Array:
	var file := FileAccess.open(path, FileAccess.READ)
	
	if file == null:
		push_error("Cannot open file: "+path)
		
	var data = JSON.parse_string(file.get_as_text())
	
	if data == null:
		push_error("Invalid JSON: "+path)
		
	if not data is Array:
		push_error("Data must be an array: "+path)
		
	return data

func get_stat(points: int, type:String, data:Dictionary) -> Stat:
	var stat := Stat.new()
	stat.points = points
	stat.scale = data[type]
	return stat

var skill_tags_by_id: Dictionary = {}

#Dictionary
#func build_skill_tag_index() -> void:
	#skill_tags_by_id.clear()
#
	#for item in raw_skill_tag_data:
		#skill_tags_by_id[item["id"]] = item["skills"]
#
#
#func get_skills_from_tags(tags: Array) -> Array[String]:
	#var skill_list: Array[String] = []
#
	#for tag in tags:
		#if skill_tags_by_id.has(tag):
			#skill_list.append_array(skill_tags_by_id[tag])
#
	#return skill_list
