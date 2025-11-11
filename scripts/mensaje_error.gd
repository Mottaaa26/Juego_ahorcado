extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	
# FUNCION DEL BOTON REGRESAR:
# CUANDO EL USUARIO OPRIMA ESTE BOTÓN, LA ESCENA SE QUITARÁ, SIGUIENDO CON LA EJECUCIÓN 
# DEL ARBOL PRINCIPAL DEL JUEGO.
func _on_button_regresar_pressed() -> void:
	
	# EJECUTAMOS EL SONIDO CON EL METODO .PLAY() Y USAMOS AWAIT PARA ESPERAR A QUE EL PROCESO TERMINE.
	var audio = $AudioStreamPlayer
	audio.play()
	await audio.finished
	
	# QUITAMOS LA ESCENA DE LA VISTA
	self.visible = false

# FUNCION PARA ASIGNAR EL TEXTO A LA ESCENA DEPENDIENDO LA VALIDACION.
func set_mensaje(texto: String) -> void:
	var label = $Label
	if label != null:
		label.text = texto
