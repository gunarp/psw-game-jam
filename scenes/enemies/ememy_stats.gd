extends Node

class_name EnemyStats

var damage_per_second: float = 10.0
var damage_taken_multiplier: float = 1.0

## time it takes for this enemy to despawn once it leaves the screen, in seconds
var despawn_delay_s: float = 1.5

## min magnitude of knockback required for this unit to be knocked
var knockback_resistance: float = 0.1
## how quickly knockback decays
var knockback_decay: float = 0.5