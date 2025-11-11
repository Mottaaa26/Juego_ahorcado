extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
# FUNCIONALIDAD DEL BOTON "JUGAR":
# AL OPRIMIRSE EL BOTÓN, NOS ENVIARÁ A LA SIGUIENTE ESCENA.
func _on_button_jugar_pressed() -> void:
	# EJECUTAMOS EL SONIDO CON EL METODO .PLAY() Y USAMOS AWAIT PARA ESPERAR QUE EL PROCESO TERMINE.
	var audio = $VBoxContainer/sonidoBotones
	audio.play()
	await audio.finished
	
	# TENEMOS QUE OBTENER LA RUTA DE LA ESCENA QUE QUEREMOS EJECUTAR CON EL METODO CHANGE_SCENE_TO_FILE
	# DEL OBJETO GET_TREE() QUE OBTIENE EL ARBOL DE EJECUCION PRINCIPAL DEL JUEGO.
	get_tree().change_scene_to_file("res://scenes/name_conf.tscn")


# FUNCIONALIDAD DEL BOTON "SALIR":
# AL OPRIMIRSE EL BOTÓN CERRRARÁ LA EJECUCION DEL JUEGO Y REPRODUCIRÁ EL EFECTO DE SONIDO.
func _on_button_salir_pressed() -> void:
	# EJECUTAMOS EL SONIDO CON EL METODO .PLAY() Y USAMOS AWAIT PARA ESPERAR A QUE EL PROCESO TERMINE.
	var audio = $VBoxContainer/sonidoBotones
	audio.play()
	await audio.finished
	
	#LINEA PARA CERRAR EL ARBOL DE EJECUCION PRINCIPAL DEL JUEGO.
	get_tree().quit()
