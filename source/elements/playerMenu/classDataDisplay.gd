extends Control

var currentChar=null
func set_char(char=null):
	currentChar=char
	var equiped = char.equiped
	var weapon = char.equiped["weapon"]
	var def = char.equiped["armor"]
	
	$classnamelbl.text =str("job:",currentChar.wanderclass)
	$atklbl.text=str("atk:",currentChar.atk)
	$deflbl.text=str("def:",currentChar.def)
