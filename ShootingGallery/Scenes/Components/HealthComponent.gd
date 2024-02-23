extends Node2D

@export var MAX_HEALTH: int = 1
@onready var health = MAX_HEALTH

signal damaged
signal dead

func damage(amount):
	health -= amount
	damaged.emit()
	if health == 0:
		dead.emit()

func heal(amount):
	health += amount
	if health > MAX_HEALTH:
		health = MAX_HEALTH
