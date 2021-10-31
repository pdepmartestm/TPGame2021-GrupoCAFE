import wollok.game.*
import personaje.*
import arma.*
import enemigo.*
import nivel.*

object pantallaPrincipal {
	
	var property nivel = primerNivel
	var property pantalla = "muro.png"
	
	method iniciarNivel(){
		
		nivel.iniciarNivel()	
			
	}
	
	method iniciar() {
		
			self.configurarPantalla() 
			 
			self.iniciarNivel()	    	
	    	
			game.start()
		
	}

	
	method victoria(){
		
		self.agregarCosas(pantallaVictoria) 
	}
		
	method siguienteNivel(siguienteNivel){
		nivel=siguienteNivel
		siguienteNivel.iniciarNivel()
	}
	
	
	method configurarPantalla(){
		game.width(34)
		game.height(18)
		game.title("Warrior's Fights")
		game.ground(pantalla)
	}
	
	
	method perder(){
		game.addVisual(pantallaDerrota)
	}
	
	method agregarCosas(algo){
		game.addVisual(algo)
	}

	
	method removerCosas(algo){
		game.removeVisual(algo)
	}
	
	method emitirMensaje(contenido, quien){
		game.say(quien, contenido)
	}
	
	
	
}

object limites{
	
	var property alto=game.height() - 6
	var property ancho=game.width() - 2

}

class Pantalla{
	var property image
	var property position=game.at(8,4) //ponerlo en el centro
}

const pantallaVictoria = new Pantalla(image="you-win.png")
const pantallaDerrota= new Pantalla(image="game_over.png")

