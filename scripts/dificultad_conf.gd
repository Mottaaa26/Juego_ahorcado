extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# FUNCIONALIDAD DE LOS BOTONES PARA ESCOGER LA DIFICULTAD DEL JUEGO.
# AL ESCOGER LA DIFICULTAD, SE INSTANCIARÁ UN ARCHIVO JSON CON LAS PALABRAS DEDICADAS PARA CADA 
# DIFICULTAD DEL JUEGO.
	
# SI SE OPRIME ESTE BOTON EL JUGADOR ENTRARÁ AL JUEGO CON LA DIFICULTAD MEDIA
func _on_button_medio_pressed() -> void:
	
	# EJECUTAMOS EL SONIDO CON EL METODO .PLAY() Y USAMOS AWAIT PARA ESPERAR A QUE EL PROCESO TERMINE.
	var audio = $VBoxContainer/sonidoBotones
	audio.play()
	await audio.finished
	
	# ASIGNAMOS LA DIFICULTAD A NORMAL EN LA VARIABLE GLOBAL
	Global.dificultad_actual = "normal"
	get_tree().change_scene_to_file("res://scenes/in_game.tscn")
	

# SI SE OPRIME ESTE BOTÓN EL JUGADOR ENTRARÁ AL JUEGO CON LA DIFICULTAD DIFICIL
func _on_button_dificil_pressed() -> void:
	
	# EJECUTAMOS EL SONIDO CON EL METODO .PLAY() Y USAMOS AWAIT PARA ESPERAR A QUE EL PROCESO TERMINE.
	var audio = $VBoxContainer/sonidoBotones
	audio.play()
	await audio.finished
	
	# ASIGNAMOS LA DIFICULTAD A DIFICIL EN LA VARIABLE GLOBAL
	Global.dificultad_actual = "dificil"
	get_tree().change_scene_to_file("res://scenes/in_game.tscn")
