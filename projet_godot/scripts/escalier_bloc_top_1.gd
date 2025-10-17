extends Area2D

# On garde une référence au joueur quand il entre dans la zone
var joueur_dans_zone = null

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.is_in_group("joueur"):
		joueur_dans_zone = body

func _on_body_exited(body):
	if body.is_in_group("joueur"):
		joueur_dans_zone = null

func _physics_process(delta):
	if joueur_dans_zone:
		if Input.is_action_pressed("monter"):
			joueur_dans_zone.velocity.y = -150  # vitesse de montée
		elif Input.is_action_pressed("descendre"):
			joueur_dans_zone.velocity.y = 150   # vitesse de descente
		else:
			# S'il ne fait rien, on bloque le mouvement vertical
			joueur_dans_zone.velocity.y = 0
