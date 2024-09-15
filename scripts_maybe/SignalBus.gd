extends Node

signal storm()

signal ship_damage_hp(amount: float)

signal weapon_change(the_weapon)

signal stat_set_level(stat: Upgrades.UpgradeType, level: int)

signal ui_buy_level(upgrade: Upgrades.UpgradeData)

signal ui_change_category(category: String)

signal game_lose()
