extends Node

signal go(colour)
signal stop
signal beat
signal enemy_shoot
signal new_cycle
signal level_done

enum COLOURS {BLACK, YELLOW, GREEN, RED}

signal score_add(reason, amount)
