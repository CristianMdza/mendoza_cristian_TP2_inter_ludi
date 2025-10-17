extends Area2D

@export var distance: float = 128.0 # 4 cases de 32px (4 * 32).
@export var speed: float = 0.5 # Vitesse du mouvement.
@export var rotation_speed: float = 180.0 # Degrés par seconde.

var direction: int = 1
var start_y: float

func _ready():
	start_y = position.y
	$CollisionShape2D.disabled = false
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	# Rotation
	rotation_degrees += rotation_speed * delta

	# Mouvement vertical alternant.
	position.y = start_y + sin(Time.get_ticks_msec() / 500.0 * speed) * distance

func _on_body_entered(body):
	if body.name == "Joueur":
		body.die() # Celui là, appelle une fonction "die()" dans le script du Joueur.
