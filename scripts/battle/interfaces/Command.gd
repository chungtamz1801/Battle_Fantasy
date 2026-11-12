extends Resource

class_name Command
 
enum CommandType{
	ATTACK,
	MOVING,
	COUNTER,
	STATENESS
}

var targets: Array[Player]
var commandType: CommandType
	
func excute()->void:
	pass
