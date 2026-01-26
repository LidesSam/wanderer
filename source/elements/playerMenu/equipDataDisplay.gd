extends Control

var currentChar=null
func set_char(char=null):
	currentChar=char
	update_display()
	
func update_display():
	var equiped = currentChar.equiped
	var weapon = currentChar.equiped["weapon"]
	var armor = currentChar.equiped["armor"]
	
	if weapon:
		$weapon/Label.text=weapon.get_display_text()
	else:
		$weapon/Label.text="FREE"
	
	if armor:
		$armor/Label.text=armor.get_display_text()
	else:
		$armor/Label.text="FREE"
	
