# EquipableItem.gd
extends Resource
class_name EquipableItem

# Attack type options
enum AttackType { HIT, SLASH, MAGIC }

# Attribute options
enum Attribute { NONE, FIRE, THUNDER, ICE }

# Editable in the Inspector (Godot 4.x)
@export var name: String = "Free"
@export var atk: int = 0
@export var def: int = 0

@export var attack_type: AttackType = AttackType.HIT
@export var attribute: Attribute = Attribute.NONE

# Optional metadata
@export var description: String = ""
@export var icon: Texture2D
