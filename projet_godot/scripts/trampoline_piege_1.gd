extends Area2D

@export var force_saut_verticale = -700.0   # vers le haut
@export var force_saut_horizontale = -400.0 # vers la gauche (négatif = gauche, positif = droite)
@export var delai_fermeture = 0.4

var joueur_dedans = null

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	$Sprite2D.texture = load("res://assets/trampoline_ferme.png")

func _on_body_entered(body):
	if body.is_in_group("joueur"):
		joueur_dedans = body
		
		# Joue l'animation d'ouverture.
		$AnimationPlayer.play("ouvrir")
		
		# Applique une force diagonale (haut + gauche)
		body.velocity.y = force_saut_verticale
		body.velocity.x = force_saut_horizontale
		
		# (Ça c'est optionnel) petit son.
		if $AudioStreamPlayer:
			$AudioStreamPlayer.play()

func _on_body_exited(body):
	if body.is_in_group("joueur"):
		joueur_dedans = null
		
		# Ferme le trampoline après un petit délai.
		await get_tree().create_timer(delai_fermeture).timeout
		$AnimationPlayer.play("fermer")
