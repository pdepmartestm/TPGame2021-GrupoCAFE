import wollok.game.*
import arma.*
import personaje.*
import pantallaPrincipal.*

class Fondo {
	var property image 
	var property position = game.origin()


}


const fondoNivelUno = new Fondo(image= "escenarioArena.png")
const fondoNivelDos = new Fondo(image= "orillaLago.jpg")

const menuPantallaInicial = new Fondo(image="menuInicial.png")

