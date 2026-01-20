extends Control

var currentChar=null
func set_char(char=null):
	currentChar=char
	var equiped = char.equiped
	var weapon = char.equiped["weapon"]
	var armor = char.equiped["armor"]
	
	if weapon:
		$weapon/Label.text=weapon.get_display_text()
	else:
		$weapon/Label.text="FREE"
	
	if armor:
		$armor/Label.text=armor.get_display_text()
	else:
		$armor/Label.text="FREE"
