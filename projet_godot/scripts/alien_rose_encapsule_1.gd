extends Area2D

@export var float_height = 10.0   # Amplitude du mouvement vertical (en pixels)
@export var float_speed = 2.0     # Vitesse du mouvement vertical
@export var scale_amount = 0.05    # Amplitude de la pulsation (scale)
@export var scale_speed = 1.0     # Vitesse de la pulsation

var start_y                       # Position de départ sur l'axe Y

func _ready():
	# Sauvegarde la position de départ.
	start_y = position.y

	# Lance les deux animations.
	animate_float_scale()

func _process(_delta):
	# Effet de flottement vertical (comme le diamant).
	position.y = start_y + sin(Time.get_ticks_msec() / 1000.0 * float_speed) * float_height

func animate_float_scale():
	# Effet de "respiration" (scale qui augmente et diminue).
	var tween = create_tween()
	tween.tween_property(self, "scale", self.scale * (1 + scale_amount), scale_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", self.scale, scale_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(animate_float_scale)
