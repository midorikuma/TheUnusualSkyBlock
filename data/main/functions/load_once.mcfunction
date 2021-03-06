##############################
### 初回ロード処理
##############################

###ステータスやトリガー
scoreboard objectives add HP health HP
scoreboard objectives add MP dummy MP
scoreboard objectives add MPMax dummy MP最大値
scoreboard objectives add Level dummy レベル
scoreboard objectives add Armor armor 防御力
scoreboard objectives add KillCount playerKillCount 討伐数
scoreboard objectives add SneakTime minecraft.custom:minecraft.sneak_time スニーク時間
scoreboard objectives add UseSupportRed minecraft.used:minecraft.pig_spawn_egg サポートエッグルビー使用
scoreboard objectives add UseSupportBlue minecraft.used:minecraft.drowned_spawn_egg サポートエッグサファイア使用
###変数や定数、カウンタ
scoreboard objectives add Global dummy グローバル変数
scoreboard objectives add Const dummy 定数
scoreboard objectives add Count dummy カウント
scoreboard objectives add DoomCount dummy 死の宣告カウント
scoreboard objectives add TorchCount dummy トカルトトーチ消費カウント
###ID系
scoreboard objectives add ID dummy 紐付けID
###設定されたスキル
scoreboard objectives add ModeSkill dummy 現在のモードスキル
scoreboard objectives add ModeSkillRed dummy モードスキルルビー
scoreboard objectives add ModeSkillBlue dummy モードスキルサファイア
scoreboard objectives add ShowSkillNo dummy 表示スキル番号
###スキル系
scoreboard objectives add MPHealingWait dummy MP回復ウェイト
scoreboard objectives add MPConsumption dummy MP消費量
scoreboard objectives add Damage dummy モブ付与ダメージ
scoreboard objectives add BurstTrigger dummy バースト発動カウント
scoreboard objectives add IronWill dummy アイアンウィル
###からくり士スキル系
scoreboard objectives add PuppetScore dummy パペット制御用スコア
scoreboard objectives add PupRecordLevel dummy レコード特性のレベル
scoreboard objectives add PupRecordType dummy レコードの種類
scoreboard objectives add PupRecordSlot dummy レコードのスロット
scoreboard objectives add PupSwimmability dummy パペット水中機動力
scoreboard objectives add PupFlyability dummy パペット空中機動力
scoreboard objectives add PupMobility dummy パペット陸上機動力
scoreboard objectives add PupCurrentSlot dummy パペット行動スロット
scoreboard objectives add PuppetWait dummy パペット行動ウェイト


###定数
scoreboard players set $-1 Const -1
scoreboard players set $2 Const 2
scoreboard players set $3 Const 3
scoreboard players set $4 Const 4
scoreboard players set $5 Const 5
scoreboard players set $10 Const 10
scoreboard players set $20 Const 20
scoreboard players set $30 Const 30
scoreboard players set $50 Const 50
scoreboard players set $100 Const 100
scoreboard players set $200 Const 200
scoreboard players set $300 Const 300
scoreboard players set $10000 Const 10000
scoreboard players set $99999 Const 99999
scoreboard players set $100000 Const 100000
scoreboard players set $112000 Const 112000
scoreboard players set $MWCBase Const 65536
scoreboard players set $MWCMultiplier Const 31743
###バースト初期化
scoreboard players set #Aura MP 10000
###イベントタイマー初期化
scoreboard players set $EventTimer Count 100
###乱数初期化
summon minecraft:area_effect_cloud ~ ~ ~ {Radius:0f,RadiusPerTick:0f,RadiusOnUse:0f,DurationOnUse:0,Age:0,WaitTime:1,ReapplicationDelay:0,Duration:0,Tags:[Initialized]}
execute store result score $RndMWC Global run data get entity @e[distance=..1,type=minecraft:area_effect_cloud,limit=1] UUIDMost 0.0000000001
execute store result score $RndMWCCarry Global run data get entity @e[distance=..1,type=minecraft:area_effect_cloud,limit=1] UUIDLeast 0.0000000001
execute if score $RndMWC Global matches ..0 run scoreboard players operation $RndMWC Global *= $-1 Const
execute if score $RndMWCCarry Global matches ..0 run scoreboard players operation $RndMWCCarry Global *= $-1 Const
scoreboard players operation $RndMWC Global %= $MWCBase Const
scoreboard players operation $RndMWCCarry Global /= $MWCBase Const

###チーム作成
team add NoCollision 衝突判定なし
team option NoCollision collisionRule never
team option Friendly friendlyfire false
team option Friendly collisionRule never

###ゲームルール系
setworldspawn 10 4 10


###エンティティ系
#$CloseAttack 1
#$CloseRangeAttack 2
#$LongAttack 3
#$LongRangeAttack 4
#$EffectAttack 5

#$Defense 6
#$HealthCure 7
#$EffectCure 8
#$MagicCure 9

#$Fly 10
#$Swim 11
#$Mobility 12

summon minecraft:area_effect_cloud ~ ~ ~ {Radius:0f,RadiusPerTick:0f,RadiusOnUse:0f,DurationOnUse:0,Age:-2147483648,WaitTime:2147483647,ReapplicationDelay:2147483647,Duration:2147483647,Particle:"minecraft:block minecraft:air",Tags:[Initialized,PupRecordEntity,PuppetClose],CustomName:"[\"CloseAttack\"]"}
scoreboard players set @e[name=CloseAttack] PupRecordType 1
summon minecraft:area_effect_cloud ~ ~ ~ {Radius:0f,RadiusPerTick:0f,RadiusOnUse:0f,DurationOnUse:0,Age:-2147483648,WaitTime:2147483647,ReapplicationDelay:2147483647,Duration:2147483647,Particle:"minecraft:block minecraft:air",Tags:[Initialized,PupRecordEntity,PuppetClose],CustomName:"[\"CloseRangeAttack\"]"}
scoreboard players set @e[name=CloseRangeAttack] PupRecordType 2
summon minecraft:area_effect_cloud ~ ~ ~ {Radius:0f,RadiusPerTick:0f,RadiusOnUse:0f,DurationOnUse:0,Age:-2147483648,WaitTime:2147483647,ReapplicationDelay:2147483647,Duration:2147483647,Particle:"minecraft:block minecraft:air",Tags:[Initialized,PupRecordEntity,PuppetLong],CustomName:"[\"LongAttack\"]"}
scoreboard players set @e[name=LongAttack] PupRecordType 3
summon minecraft:area_effect_cloud ~ ~ ~ {Radius:0f,RadiusPerTick:0f,RadiusOnUse:0f,DurationOnUse:0,Age:-2147483648,WaitTime:2147483647,ReapplicationDelay:2147483647,Duration:2147483647,Particle:"minecraft:block minecraft:air",Tags:[Initialized,PupRecordEntity,PuppetLong],CustomName:"[\"LongRangeAttack\"]"}
scoreboard players set @e[name=LongRangeAttack] PupRecordType 4
summon minecraft:area_effect_cloud ~ ~ ~ {Radius:0f,RadiusPerTick:0f,RadiusOnUse:0f,DurationOnUse:0,Age:-2147483648,WaitTime:2147483647,ReapplicationDelay:2147483647,Duration:2147483647,Particle:"minecraft:block minecraft:air",Tags:[Initialized,PupRecordEntity,PuppetLong],CustomName:"[\"EffectAttack\"]"}
scoreboard players set @e[name=EffectAttack] PupRecordType 5

summon minecraft:area_effect_cloud ~ ~ ~ {Radius:0f,RadiusPerTick:0f,RadiusOnUse:0f,DurationOnUse:0,Age:-2147483648,WaitTime:2147483647,ReapplicationDelay:2147483647,Duration:2147483647,Particle:"minecraft:block minecraft:air",Tags:[Initialized,PupRecordEntity],CustomName:"[\"Defense\"]"}
scoreboard players set @e[name=Defense] PupRecordType 6
summon minecraft:area_effect_cloud ~ ~ ~ {Radius:0f,RadiusPerTick:0f,RadiusOnUse:0f,DurationOnUse:0,Age:-2147483648,WaitTime:2147483647,ReapplicationDelay:2147483647,Duration:2147483647,Particle:"minecraft:block minecraft:air",Tags:[Initialized,PupRecordEntity],CustomName:"[\"HealthCure\"]"}
scoreboard players set @e[name=HealthCure] PupRecordType 7
summon minecraft:area_effect_cloud ~ ~ ~ {Radius:0f,RadiusPerTick:0f,RadiusOnUse:0f,DurationOnUse:0,Age:-2147483648,WaitTime:2147483647,ReapplicationDelay:2147483647,Duration:2147483647,Particle:"minecraft:block minecraft:air",Tags:[Initialized,PupRecordEntity],CustomName:"[\"EffectCure\"]"}
scoreboard players set @e[name=EffectCure] PupRecordType 8
summon minecraft:area_effect_cloud ~ ~ ~ {Radius:0f,RadiusPerTick:0f,RadiusOnUse:0f,DurationOnUse:0,Age:-2147483648,WaitTime:2147483647,ReapplicationDelay:2147483647,Duration:2147483647,Particle:"minecraft:block minecraft:air",Tags:[Initialized,PupRecordEntity],CustomName:"[\"MagicCure\"]"}
scoreboard players set @e[name=MagicCure] PupRecordType 9

summon minecraft:area_effect_cloud ~ ~ ~ {Radius:0f,RadiusPerTick:0f,RadiusOnUse:0f,DurationOnUse:0,Age:-2147483648,WaitTime:2147483647,ReapplicationDelay:2147483647,Duration:2147483647,Particle:"minecraft:block minecraft:air",Tags:[Initialized,PupRecordEntity,PuppetMove],CustomName:"[\"Fly\"]"}
scoreboard players set @e[name=Fly] PupRecordType 10
summon minecraft:area_effect_cloud ~ ~ ~ {Radius:0f,RadiusPerTick:0f,RadiusOnUse:0f,DurationOnUse:0,Age:-2147483648,WaitTime:2147483647,ReapplicationDelay:2147483647,Duration:2147483647,Particle:"minecraft:block minecraft:air",Tags:[Initialized,PupRecordEntity,PuppetMove],CustomName:"[\"Swim\"]"}
scoreboard players set @e[name=Swim] PupRecordType 11
summon minecraft:area_effect_cloud ~ ~ ~ {Radius:0f,RadiusPerTick:0f,RadiusOnUse:0f,DurationOnUse:0,Age:-2147483648,WaitTime:2147483647,ReapplicationDelay:2147483647,Duration:2147483647,Particle:"minecraft:block minecraft:air",Tags:[Initialized,PupRecordEntity,PuppetMove],CustomName:"[\"Mobility\"]"}
scoreboard players set @e[name=Mobility] PupRecordType 12

