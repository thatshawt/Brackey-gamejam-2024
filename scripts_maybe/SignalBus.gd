extends Node

signal ship_damage_hp(amount: float)

signal game_lose()

signal weapon_change(the_weapon: Weapon.weapons)

signal stat_set_level(stat: Upgrades.UpgradeType, level: int)

signal ui_change_category(category: String)
