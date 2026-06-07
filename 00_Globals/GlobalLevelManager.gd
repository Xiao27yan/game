#在项目设置里做了自动加载
extends Node

var current_tilemap_bounds :Array[Vector2]
#把关卡变换的信息发送出去
signal TileMapBoundChanged(bounds:Array[Vector2])

func ChangeTilemapBounds(bounds:Array[Vector2])->void:
	current_tilemap_bounds = bounds
	TileMapBoundChanged.emit(bounds)
	
