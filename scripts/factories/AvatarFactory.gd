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
	avatar.Normal_Attack = avatar_data.Normal_Attack
	#avatar.Skills = avatar_data.Skills
	
	return avatar
