extends Control

@onready var teclado_container = $ContenedorLetras
@onready var pregunta_container = $ContenedorPregunta/pregunta

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# SE VERIFICA LA DIFICULTAD ESCOGIDA DESDE EL OTRO SCRIPT PARA LLAMAR 
	# A LOS ARCHIVOS JSON DEPENDIENDO DE LA DIFICULTAD.
	
	# CREAMOS LAS VARIABLES QUE SE GENERAN EN AMBAS DIFICULTADES
	var _intentos = 6
	var _puntuacion = 0
	var _tiempo = 0
	var _pregunta = ""
	var _palabra = ""
	
	var preguntas = FileAccess.open("res://data/preguntas.json", FileAccess.READ)
	var respuestas = FileAccess.open("res://data/respuestas.json", FileAccess.READ)
	
	var preguntas_dict = {}
	var respuestas_dict = {}
	
	if (preguntas and respuestas):
		var contenido_preguntas = preguntas.get_as_text()
		var contenido_respuestas = respuestas.get_as_text()
		
		var resultado_preguntas = JSON.parse_string(contenido_preguntas)
		var resultado_respuestas = JSON.parse_string(contenido_respuestas)
		
		if (resultado_preguntas and resultado_respuestas):
			preguntas_dict = resultado_preguntas
			respuestas_dict = resultado_respuestas
	
	if(Global.dificultad_actual == "normal"):
		var _preguntas_normales = preguntas_dict.get("normal")
		var _respuestas_normales = respuestas_dict.get("normales")
		
	
	# SE CREA EL ABECEDARIO EN UNA VARIABLE PARA ITERAR Y CREAR LOS BOTONES PARA QUE 
	# EL USUARIO PUEDA ESCRIBIR.
	var letras = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"
	teclado_container.columns = 9  # Puedes ajustar esto según el espacio

	for letra in letras:
		var boton = Button.new()
		boton.text = letra
		boton.name = "Boton_%s" % letra
		boton.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		boton.connect("pressed", Callable(self, "_on_letra_presionada").bind(letra))
		teclado_container.add_child(boton)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_letra_presionada(letra):
	print("letra presionada: ", letra)
