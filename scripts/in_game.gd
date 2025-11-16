extends Control

@onready var teclado_container = $ContenedorLetras
@onready var pregunta_container = $ContenedorPregunta/pregunta
@onready var sonido_botones = $sonidoBotones
@onready var palabra_display = $palabraDisplay

# GENERADOR DE NUMEROS ALEATORIOS PARA ESCOGER LA PALABRA.
var rng = RandomNumberGenerator.new()
var _preguntas_disponibles: Array = []
var _respuestas_disponibles: Array = []
var _indices_usados: Array = []
var _palabra_actual: String = ""
var _palabra_adivinando: Array = []
var _intentos = 6
var _puntuacion = 0
var _tiempo = 0

const LETRA_THEME: StyleBoxFlat = preload("res://resources/letra_boton.tres")
const BUTTON_FONT: FontFile = preload("res://fonts/Good-Game.ttf")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# INSTANCIAMOS RNG PARA GENERAR EL NUMERO ALEATORIO CADA VEZ QUE LA PARTIDA INICIA.
	rng.randi_range(1, 10)
	
	# SE VERIFICA LA DIFICULTAD ESCOGIDA DESDE EL OTRO SCRIPT PARA LLAMAR 
	# A LOS ARCHIVOS JSON DEPENDIENDO DE LA DIFICULTAD.
	
	# CREAMOS LAS VARIABLES QUE SE GENERAN EN AMBAS DIFICULTADES
	
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
	
	# CODIGO PARA FILTRAR LAS PREGUNTAS Y RESPUESTAS POR LA DIFICULTAD Y ESCOGER UNA PREGUNTA
	# JUNTO A SU RESPECTIVA RESPUESTA
	
	# AHORA MIRAMOS LA VARIABLE GLOBAL dificultad_actual PARA DETERMINAR LA DIFICULTAD
	# DEL JUEGO.
	if(Global.dificultad_actual == "normal"):
		var preguntas_normales = preguntas_dict.get("normal")
		var respuestas_normales = respuestas_dict.get("normales")
		
		_preguntas_disponibles = preguntas_normales.get("faciles", [])
		_respuestas_disponibles = respuestas_normales.get("faciles", [])
		
		_generar_nueva_palabra()
	if(Global.dificultad_actual == "dificil"):
		var preguntas_dificiles =  preguntas_dict.get("dificil")
		var respuestas_dificiles = respuestas_dict.get("dificiles")
		
		_preguntas_disponibles = preguntas_dificiles.get("dificiles")
		_respuestas_disponibles = respuestas_dificiles.get("dificiles")
		
		_generar_nueva_palabra()
	
	# SE CREA EL ABECEDARIO EN UNA VARIABLE PARA ITERAR Y CREAR LOS BOTONES PARA QUE 
	# EL USUARIO PUEDA ESCRIBIR.
	var letras = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"
	teclado_container.columns = 9  # Puedes ajustar esto según el espacio

	for letra in letras:
		var boton = Button.new()
		
		boton.add_theme_stylebox_override("normal", LETRA_THEME)
		boton.add_theme_font_override("font", BUTTON_FONT)
		boton.add_theme_font_size_override("font_size", 35)
		boton.text = letra
		boton.name = "Boton_%s" % letra
		boton.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		boton.connect("pressed", Callable(self, "_on_letra_presionada").bind(letra))
		teclado_container.add_child(boton)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_letra_presionada(letra):
	
	# EJECUTAMOS EL SONIDO CON EL METODO .PLAY() Y USAMOS AWAIT PARA ESPERAR A QUE EL PROCESO TERMINE.
	var audio = sonido_botones
	audio.play()
	await audio.finished
	
	var letra_mayuscula = letra.to_upper()
	var acierto = false
	
	var boton = teclado_container.get_node("Boton_%s" % letra_mayuscula)
	if boton:
		boton.disabled = true
		
	for i in range(_palabra_actual.length()):
		if _palabra_actual[i] == letra_mayuscula:
			_palabra_adivinando[i] = letra_mayuscula
			acierto = true
			
	if acierto:
		_actualizar_palabra_display()
		
		if not "_" in _palabra_adivinando:
			print("palabra adivinada, ganaste")
	else:
		_intentos -= 1
		print("Fallo. Intentos restantes: ", _intentos)

func _generar_nueva_palabra() -> void:
	
	var num_total_palabras = _preguntas_disponibles.size()
	
	if (_indices_usados.size() >= num_total_palabras):
		# YA NO QUEDAN PALABRAS
		pregunta_container.text = "¡Feclidades! Has completado todas las palabras disponibles."
		return;

	var max_indice = num_total_palabras -1
	var nuevo_indice: int
	
	while true:
		nuevo_indice = rng.randi_range(0, max_indice)
		
		if not nuevo_indice in _indices_usados:
			break;
	
	_indices_usados.append(nuevo_indice)
	
	var pregunta_seleccionada = _preguntas_disponibles[nuevo_indice]
	_palabra_actual = _respuestas_disponibles[nuevo_indice].to_upper()
	
	pregunta_container.text = pregunta_seleccionada
	
	_palabra_adivinando.clear()
	for char in _palabra_actual:
		if char == " ":
			_palabra_adivinando.append(" ")
		else:
			_palabra_adivinando.append("_")
	_actualizar_palabra_display()
	
func _on_button_salir_pressed() -> void:
	
	# EJECUTAMOS EL SONIDO CON EL METODO .PLAY() Y USAMOS AWAIT PARA ESPERAR A QUE EL PROCESO TERMINE.
	var audio = sonido_botones
	audio.play()
	await audio.finished

	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _actualizar_palabra_display() -> void:
	palabra_display.text = " ".join(_palabra_adivinando)
	
