class_name Rune extends Node

var rune_name := "name"
var description := "description"
var price := 1
var shop_chance := 10

func _init(name:String, rune_description:String, rune_price:int=5, rune_shop_chance:int=10):
	rune_name = name
	description = rune_description
	price = rune_price
	shop_chance = rune_shop_chance

func use():
	print("used "+rune_name)
