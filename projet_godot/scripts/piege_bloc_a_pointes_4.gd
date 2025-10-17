extends Area2D

func _ready():
	# Active la détection et connecte le signal.
	$CollisionShape2D.disabled = false
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	# Si le corps qui entre est le joueur, déclenche sa mort.
	if body.name == "Joueur":
		body.die()
