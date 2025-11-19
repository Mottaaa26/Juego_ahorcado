extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# FUNCIONALIDAD DEL BOTON REGRESAR. SI SE OPRIME ESTE BOTON SE REGRESA AL MENU PRINCIPAL.
func _on_button_regresar_pressed() -> void:
	
	# EJECUTAMOS EL SONIDO CON EL METODO .PLAY() Y USAMOS AWAIT PARA ESPERAR A QUE EL PROCESO TERMINE.
	var audio = $AudioStreamPlayer
	audio.play()
	await audio.finished
	
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
