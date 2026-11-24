extends RefCounted

class_name AvatarFactory

static func create_avatar(avatar_id: String) -> Avatar:
	var avatar_data := GameManager.avatar_repo.get_avatar(avatar_id)
	var avatar := Avatar.new()
	
	avatar.Name = avatar_data.Name
	avatar.HP = avatar_data.HP.get_result_stat()
	avatar.Current_HP = avatar_data.HP.get_result_stat()
	avatar.ATK = avatar_data.ATK.get_result_stat()
	avatar.DEF = avatar_data.DEF.get_result_stat()
	avatar.MAG = avatar_data.MAG.get_result_stat()
	avatar.RES = avatar_data.RES.get_result_stat()
	avatar.SPD = avatar_data.SPD.get_result_stat()
	avatar.MP = avatar_data.MP.get_result_stat()
	avatar.MRG = avatar_data.MRG.get_result_stat()
	avatar.CRIT = avatar_data.CRIT.get_result_stat()
	avatar.Actions = create_action_data(avatar_data.Normal_Attack) 
	avatar.Skills = create_skill_data(avatar_data.Skills) 
	avatar.Passives = avatar_data.Passives
	
	avatar.Max_AP = 3
	avatar.Move_Budget = avatar.SPD * 10	
	
	return avatar
	
static func create_action_data(id: StringName) -> Array[ActionData]:
	var result: Array[ActionData] = []
	var action_data = load("res://data/tres/actions/attacks/%s.tres" % id)
	result.append(action_data as ActionData)
	action_data = load("res://data/tres/actions/commons/move.tres")
	result.append(action_data as ActionData)
	return result
	
static func create_skill_data(ids: Array[StringName]) -> Array[SkillData]:
	var result: Array[SkillData] = []
	for id in ids:
		var skill_data = load("res://data/tres/actions/skills/%s.tres" % id)
		result.append(skill_data as SkillData)
	return result

	
