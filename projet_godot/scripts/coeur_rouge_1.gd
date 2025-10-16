extends Area2D

@export var float_amount = 0.1
@export var float_speed = 1.0

signal collected

func _ready():
	# Animation flottante.
	animate_float()

	# Détection du joueur.
	connect("body_entered", Callable(self, "_on_body_entered"))

func animate_float():
	var tween = create_tween()
	tween.tween_property(self, "scale", self.scale * (1 + float_amount), float_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", self.scale, float_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(animate_float) # Relance l'animation quand elle se termine.

func _on_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("collected")  # Optionnel : pour notifier le jeu principal.
		queue_free()  # L'objet disparaît (ramassé).
