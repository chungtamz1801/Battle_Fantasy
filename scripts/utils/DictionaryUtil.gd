extends RefCounted

class_name DictionaryUtil

static func print_dictionary(dictionary: Dictionary):
	print(JSON.stringify(dictionary, "\t"))
