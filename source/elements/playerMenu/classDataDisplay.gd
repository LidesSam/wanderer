extends Control

var currentChar=null
func set_char(char=null):
	currentChar=char
	$classnamelbl.text =str("job:",currentChar.wanderclass)
	$atklbl.text=str("atk:",currentChar.atk)
	$deflbl.text=str("def:",currentChar.def)
