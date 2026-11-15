extends Node2D

const Scores = preload("uid://c0hxu03wlcdic")
@onready var score: Control = $CanvasLayer/Score

@export var item: InvItem
var player = null

var count_coins = 0;

func handle_coins(value):
	count_coins +=value
	score.handle_gain_coins(count_coins)
	#print(count_coins)
