# EquipableItem.gd
extends AnimatedSprite2D
# Attack type options
enum AttackType { HIT, SLASH, MAGIC }

# Attribute options
enum Attribute { NONE, FIRE, THUNDER, ICE }

# type options
enum Type {WEAPON, ARMOR }

# Editable in the Inspector (Godot 4.x)
@export var atk: int = 0
@export var def: int = 0

@export var attack_type: AttackType = AttackType.HIT
@export var attribute: Attribute = Attribute.NONE

# Optional metadata
@export var description: String = ""
@export var icon: Texture2D

func get_display_text():
	return str(name," atk:",atk," def:",def)

func define_as_weapon( weaponName = "stick"):
	name=weaponName
	match weaponName:
		"stick":
			atk=2
			def=0
			attack_type =AttackType.HIT
			description="wood stick simple cheap effective"
		"guantlet":
			atk=1
			def=1
			attack_type =AttackType.HIT
			description="Reinforced globe, to block and punch"
		"sword":
			atk=3
			def=0
			attack_type =AttackType.SLASH
			description="Basic sword quite sharp"
		"wand":
			atk=2
			def=0
			attack_type =AttackType.MAGIC
			description="magic inbued in this crunk of wood can damage non corporeal entities."
		_:
			define_as_weapon()
func define_as_armor( armorName = "coat" ):
	name=armorName
	match armorName:
		"coat":
			atk=0
			def=2
			description="cloth coard"
		"heavy coat":
			atk=0
			def=2
			description="clotc coard"
		"raincoat":
			atk=0
			def=1
			attribute =Attribute.THUNDER
			description="Isulated, ideal for thunderstorms"
		"thin jacket":
			atk=1
			def=0
			attribute =Attribute.FIRE
			description="Oddly refreshing, you feel stronger"
		"wintercoat":
			atk=0
			def=1
			attribute =Attribute.ICE
			description="Warm coat"
		_:
			define_as_armor()
