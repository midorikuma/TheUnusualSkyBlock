##############################
### 討伐ボーナス回復
##############################

###ボーナス付与
execute as @a run function effect_manager:bonus_healing_apply

###カウントリセット
function calc_manager:update_random
scoreboard players operation $Healing Count = $Random Global
scoreboard players operation $Healing Count %= $50 Const
scoreboard players add $Healing Count 50
