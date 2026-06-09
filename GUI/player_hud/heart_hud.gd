class_name HeartGUI extends Node

#这是单个Heart场景里的Sprite
@onready var sprite: Sprite2D = $Sprite2D

#每当值变化的时候就自动调用以下函数
var value:int = 2:
	set(_value):
		value =_value
		update_sprite()


#sprite2D有个东西属性是frame 可以改变精灵图显示的帧
func update_sprite()->void:
	sprite.frame = value
