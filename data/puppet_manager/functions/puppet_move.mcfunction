##############################
### からくり移動処理
##############################

###設定読み込み(TODO)


###マスタータグ付与(不要)
###リンクID読み込み
scoreboard players operation $PuppetID ID = @s ID

###子パペットタグ付与
execute as @e[tag=Puppet] if score @s ID = $PuppetID ID run tag @s add ActivePuppet

###ダウンサーチャーのみタグ付与
execute as @e[tag=DownSearcher] if score @s ID = $PuppetID ID run tag @s add ActiveDownSearcher


###落下チェック
scoreboard players set $Falling PuppetScore 0
execute as @e[tag=ActivePuppet,limit=1] at @s positioned ~ ~1.8 ~ unless entity @e[dy=10,tag=ActiveDownSearcher,limit=1] run scoreboard players set $Falling PuppetScore 1

###上昇チェック
scoreboard players set $CrimbingGap PuppetScore 0
execute as @e[tag=ActivePuppet,limit=1] at @s positioned ~ ~-0.5 ~ unless entity @e[dy=-10,tag=ActiveDownSearcher,limit=1] run scoreboard players set $CrimbingGap PuppetScore 1
execute if score $CrimbingGap PuppetScore matches 1.. as @e[tag=UpSearcher] if score @s ID = $PuppetID ID at @s positioned ~ ~-1 ~ if entity @e[dy=-10,tag=ActiveDownSearcher,limit=1] run function puppet_manager:crimbing/calc_gap

####次位置タグ付与(不要)
####パペット移動
###歩行モードの時
execute as @e[tag=PuppetNext] if score @s ID = $PuppetID ID at @s run function puppet_manager:set_next/move_to_next

###登れるときは登る
execute if entity @s[tag=!Mobility2,tag=!Mobility3] if score $CrimbingGap PuppetScore matches 50..100 positioned as @e[tag=ActiveDownSearcher,limit=1] run tp @e[tag=ActivePuppet,limit=1] ~ ~ ~
execute if entity @s[tag=Mobility2] if score $CrimbingGap PuppetScore matches 50..299 positioned as @e[tag=ActiveDownSearcher,limit=1] run tp @e[tag=ActivePuppet,limit=1] ~ ~ ~
execute if entity @s[tag=Mobility3] if score $CrimbingGap PuppetScore matches 50..499 positioned as @e[tag=ActiveDownSearcher,limit=1] run tp @e[tag=ActivePuppet,limit=1] ~ ~ ~

###水中の時
execute as @e[tag=ActivePuppet,limit=1] at @s if block ~ ~1.5 ~ minecraft:water run tp @s ~ ~1 ~

###糸切れ判定
execute at @e[distance=48..,tag=Puppet,limit=1] run function puppet_manager:string_cut

###次ターゲットタグ付与
scoreboard players set $SeekFlag PuppetScore 0
##マスターが遠い場合
execute if entity @e[distance=32..,tag=ActivePuppet,limit=1] run function puppet_manager:set_next/master
##マスター優先の場合
execute if entity @s[tag=!ActiveTarget,tag=PriorPupMaster] run function puppet_manager:set_next/master
##近接攻撃優先の場合
execute if entity @s[tag=!ActiveTarget,tag=PriorPupClose] run function puppet_manager:set_next/close
##遠隔攻撃優先の場合
execute if entity @s[tag=!ActiveTarget,tag=PriorPupLong] run function puppet_manager:set_next/long
##ターゲットがない場合はマスター
execute if score $SeekFlag PuppetScore matches ..0 run function puppet_manager:set_next/master

####次位置設定
###歩行モードの時
execute store result score $SeekFlag PuppetScore if entity @e[tag=ActiveTarget,limit=1] as @e[tag=ActivePuppet,limit=1] at @s positioned ~ ~300 ~ rotated ~ 0 run function puppet_manager:set_next/position

###ターゲットが結局ない時、落下を試みる
execute if score $SeekFlag PuppetScore matches ..0 as @e[tag=ActivePuppet,limit=1] at @s positioned ~ ~300 ~ rotated ~ 0 run function puppet_manager:set_next/falling_only

###遠隔攻撃優先の場合で、敵が近い時、向きをそちらにしたまま移動させる
execute if entity @s[tag=PriorPupLong] as @e[tag=ActivePuppet,limit=1] at @s run tp @s ~ ~ ~ facing entity @e[distance=..16,tag=Mob,sort=nearest,limit=1]


###次ターゲットタグ削除
tag @e[tag=ActiveTarget] remove ActiveTarget

###次位置タグ削除(不要)

###ダウンサーチャーのみタグ付与
tag @e[tag=ActiveDownSearcher] remove ActiveDownSearcher

###パペットダメージ処理
execute if score $PuppetDamage PuppetScore matches 1.. as @e[tag=ActivePuppet,limit=1] at @s run function puppet_manager:damage_taken
###子パペットタグ削除
tag @e[tag=ActivePuppet,limit=1] remove ActivePuppet

###マスタータグ削除(不要)
