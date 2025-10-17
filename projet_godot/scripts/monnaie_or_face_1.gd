extends Area2D

@export var float_height = 10.0  # Amplitude du mouvement (en pixels).
@export var float_speed = 2.0    # Vitesse du mouvement.
var start_y                      # Position de départ sur l'axe Y.

signal collected

func _ready():
	# Sauvegarde la position de départ.
	start_y = position.y

	# Connecte le signal pour détecter le joueur.
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(_delta):
	# Mouvement vertical flottant.
	position.y = start_y + sin(Time.get_ticks_msec() / 1000.0 * float_speed) * float_height

func _on_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("collected")  # Optionnel : tu peux connecter ce signal à ton jeu principal
		queue_free()  # L'objet disparaît (ramassé)
