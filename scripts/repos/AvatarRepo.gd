extends RefCounted

class_name AvatarRepo

var avatar_data: Dictionary[String,AvatarData] = {}
var scale_data: Dictionary 
var raw_skill_tag_data: Dictionary
var raw_passive_tag_data: Dictionary

func _init():
	scale_data = FileUtil.read_data_from_file(Config.SCALE_PATH)
	raw_skill_tag_data = FileUtil.read_data_from_file(Config.SKILL_TAG_PATH)
	raw_passive_tag_data = FileUtil.read_data_from_file(Config.PASSIVE_TAG_PATH)
	load_avatar_data()

func load_avatar_data():
	var data := FileUtil.read_data_from_file(Config.AVATAR_PATH)
	for id in data.keys():
		avatar_data.set(id,from_dict(id,data[id]))

func from_dict(id: String,data: Dictionary) -> AvatarData:
	var avatar := AvatarData.new()
	var scale = scale_data.get(data.get("Scale","default"))
	
	avatar.ID = id
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

	avatar.Skills = get_skills(data)
	avatar.Passives = get_passives(data)

	return avatar

#inner_function
func get_stat(points: int, type:String, data:Dictionary) -> Stat:
	var stat := Stat.new()
	stat.points = points
	stat.scale = data[type]
	return stat

func get_avatar(avatar_id: String) -> AvatarData:
	return avatar_data[avatar_id]
	
func get_avatar_name_by_id(avatar_id: String) -> String:
	if avatar_id.is_empty():
		return "None"
	return avatar_data[avatar_id].Name
	
func get_skills(data: Dictionary) -> Array[StringName]:
	var result: Array[StringName] = []

	for skill_id in data.get("Skills", []):
		result.append(StringName(skill_id))

	return result

func get_passives(data: Dictionary) -> Array[StringName]:
	var result: Array[StringName] = []

	for passive_id in data.get("Passives", []):
		result.append(StringName(passive_id))

	return result
