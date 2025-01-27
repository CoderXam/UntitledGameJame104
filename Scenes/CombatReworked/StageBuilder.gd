extends Node

#enemies
var livingmoss = "Livingmoss"
var stonyhedgehog = "Stonyhedgehog"
var lantler = "Lantler"
var berrybushbear = "Berrybushbear"

var stagelayout = {
	1: {
		1 : null,
		2 : null,
		3 : stonyhedgehog,
		4 : stonyhedgehog,
		5:  null,
		6 : null,
		7 : null
	},
	2: {
		1 : null,
		2 : "Livingmoss",
		3 : "Berrybushbear",
		4 : "Lantler",
		5:  null,
		6 : "Stonyhedgehog",
		7 : null
	}

}
var stage2 = {
	1 : null,
	2 : "Livingmoss",
	3 : "Berrybushbear",
	4 : "Lantler",
	5:  null,
	6 : "Stonyhedgehog",
	7 : null
}
var stage3 = {
	1 : null,
	2 : "Berrybushbear",
	3 : "Berrybushbear",
	4 : "Stonyhedgehog",
	5:  "Lantler",
	6 : null,
	7 : "Lantler"
}
var stage4 = {
	1 : null,
	2 : "Berrybushbear",
	3 : "Berrybushbear",
	4 : "Berrybushbear",
	5:  "Berrybushbear",
	6 : "Lantler",
	7 : "Lantler"
}
