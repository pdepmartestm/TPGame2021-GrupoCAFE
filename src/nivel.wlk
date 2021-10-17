import pantallaPrincipal.*
import personaje.*
import enemigo.*

class Nivel {
	
	var property personajePrincipal
	var property enemigo
	var property fondo
	var property siguienteNivel=null
	
	method terminarNivel(){
		pantallaPrincipal.removerCosas(enemigo)
		pantallaPrincipal.removerCosas(personajePrincipal)
		pantallaPrincipal.siguienteNivel(siguienteNivel)
	}	
	
	
}
const segundoNivel = null
const primerNivel = new Nivel(personajePrincipal=guerrero, 
	enemigo=enanoHechicero,
	fondo="muro.png", siguienteNivel=segundoNivel)
	
