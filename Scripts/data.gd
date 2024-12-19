extends Node

@export var coords = {
	"grass": Vector2i(0, 0),
	"dirt": Vector2i(1, 0),
	"stone": Vector2i(2, 0),
	"bedrock": Vector2i(3, 0),
	"leaf": Vector2i(4, 0),
	"oak_log": Vector2i(5, 0),
	"oak_log_leaf": Vector2i(6, 0)
}

@export var items = [
	[-1,-1,0],
	[-1,-1,0],
	[-1,-1,0],
	[-1,-1,0],
	[-1,-1,0],
	[-1,-1,0],
	[-1,-1,0],
	[-1,-1,0],
	[-1,-1,0]
]

@export var godmode_items = [
	[0,0,1],
	[1,0,1],
	[2,0,1],
	[3,0,1],
	[4,0,1],
	[5,0,1],
	[6,0,1],
	[7,0,1],
	[0,1,1]
]

@export var structures = {
	"tree": [
		[Vector2(0,0),coords["dirt"]],[Vector2(0,-1),coords["oak_log"]],
		[Vector2(0,-2),coords["oak_log"]],[Vector2(-2,-3),coords["leaf"]],
		[Vector2(-1,-3),coords["leaf"]],[Vector2(0,-3),coords["oak_log_leaf"]],
		[Vector2(1,-3),coords["leaf"]],[Vector2(2,-3),coords["leaf"]],
		[Vector2(-2,-4),coords["leaf"]],[Vector2(-1,-4),coords["leaf"]],
		[Vector2(0,-4),coords["oak_log_leaf"]],[Vector2(1,-4),coords["leaf"]],
		[Vector2(2,-4),coords["leaf"]],[Vector2(-1,-5),coords["leaf"]],
		[Vector2(0,-5),coords["leaf"]],[Vector2(1,-5),coords["leaf"]]
	]
}
