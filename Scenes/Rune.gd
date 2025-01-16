class_name Rune extends Node

var rune_name := "name"
var description := "description"
var price := 5
var shop_chance := 10
var image := preload("res://Sprites/testdummy.png")
var color

var in_shop = 0 # To avoid duplicates in the shop

func _init(name:String,
 rune_description:String,
 rune_image:CompressedTexture2D=preload("res://Sprites/testdummy.png"),
 rune_price:int=5,
 rune_shop_chance:int=10,
 rune_color:Color=Color(1,1,1,1)):
	rune_name = name
	description = rune_description
	price = rune_price
	shop_chance = rune_shop_chance
	image = rune_image
	color=rune_color

func use():
	print("used "+rune_name)
