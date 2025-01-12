class_name Rune extends Node

var item_name := "name"
var description := "description"
var price := 1
var shop_chance := 10

func _init(rune_name:String, rune_description:String, rune_price:int, rune_shop_chance:int):
	item_name = rune_name
	description = rune_description
	price = rune_price
	shop_chance = rune_shop_chance

func use():
	print("used "+item_name)
