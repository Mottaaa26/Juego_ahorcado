extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# FUNCIONALIAD DEL BOTON REGRESAR:
# AL OPRIMIR ESTE BOTÓN, NOS LLEVARÁ DE REGRESO AL MENÚ PRINCIPAL.
func _on_button_regresar_pressed() -> void:
	
	# EJECUTAMOS EL SONIDO CON EL METODO .PLAY() Y USAMOS AWAIT PARA ESPERAR A QUE EL PROCESO TERMINE.
	var audio = $VBoxContainer/AudioStreamPlayer
	audio.play()
	await audio.finished
	
	# TENEMOS QUE OBTENER LA RUTA DE LA ESCENA QUE QUEREMOS EJECUTAR CON EL METODO CHANGE_SCENE_TO_FILE
	# DEL OBJETO GET_TREE() QUE OBTIENE EL ARBOL DE EJECUCION PRINCIPAL DEL JUEGO.
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
# FUNCIONALIDAD DEL BOTON CONTINUAR:
# AL OPRIMIR EL BOTON, PRIMERO SE VALIDARÁ EL NOMBRE DEL USUARIO, SI ESTE CUMPLE CON LOS REQUISITOS
# DE ENTRADA Y SI NO HAY OTRO USUARIO REGISTRADO CON ESE NOMBRE EN LA EJECUCIÓN ACTUAL.
# (LA PERSISTENCIA DE LOS DATOS SERÁ TEMPORAL POR FALTA DE TIEMPO DE DESARROLLO).
func _on_button_continuar_pressed() -> void:
	
	# EJECUTAMOS EL SONIDO CON EL METODO .PLAY() Y USAMOS AWAIT PARA ESPERAR A QUE EL PROCESO TERMINE.
	var audio = $VBoxContainer/AudioStreamPlayer
	audio.play()
	await audio.finished
	
	# OBTENEMOS EL CONTENIDO DEL TEXTEDIT Y HACEMOS VALIDACIONES BASE
	var nombre = $TextEditNombre.get_line(0).strip_edges().to_lower()
	
	# LAS VALIDACIONES SON QUE EL NOMBRE DEBE SER MENOR A 8 Y QUE SOLO CONTENGA LETRAS Y NUMEROS.
	if(nombre.length() > 8):
		mostrar_mensaje_error("El nombre debe ser menor a 8 caractéres.")
		return
	var regex = RegEx.new()
	regex.compile("^[a-zA-Z0-9]+$")
	if not regex.search(nombre):
		mostrar_mensaje_error("El nombre no debe tener carácteres especiales.")
		return
		
	# SI COMPLETA TODAS LAS VALIDACIONES CORRECTAMENTE, SE VERIFICA QUE EL NOMBRE
	# NO ESTÉ REGISTRADO EN EL TOP10
	var archivo_nombres = FileAccess.open("res://data/puntajes.json", FileAccess.READ)
	var json = JSON.parse_string(archivo_nombres.get_as_text())
	archivo_nombres.close()
	
	for key in json.keys(): 
		if(nombre == key):
			mostrar_mensaje_error("Este nombre ya está en el top10. Ingresa otro por favor.")
			return

		
	# SI NO HAY PROBLEMAS PASAMOS A LA SELECCIÓN DE DIFICULTAD
	# TENEMOS QUE OBTENER LA RUTA DE LA ESCENA QUE QUEREMOS EJECUTAR CON EL METODO CHANGE_SCENE_TO_FILE
	# DEL OBJETO GET_TREE() QUE OBTIENE EL ARBOL DE EJECUCION PRINCIPAL DEL JUEGO.
	get_tree().change_scene_to_file("res://scenes/dificultad_conf.tscn")
	
# FUNCION ENCARGA DE MOSTRAR LA ESCENA DE ERRORES PARA LAS VALIDACIONES.
func mostrar_mensaje_error(texto: String) -> void:
	
	# CARGAMOS LA ESCENA EN UNA VARIABLE, LUEGO LLAMAMOS A LA FUNCION SET_MENSAJE E INSTANCIAMOS
	# LA ESCENA EN EL ARBOL PRINCIPAL DE EJECUCION DEL JUEGO.
	var mensaje_error_scene = load("res://scenes/mensaje_error.tscn")
	var mensaje_error =  mensaje_error_scene.instantiate()
	mensaje_error.set_mensaje(texto)
	get_tree().root.add_child(mensaje_error)

	
	
