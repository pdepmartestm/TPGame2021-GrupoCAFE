import wollok.game.*
import personaje.*
import arma.*
import enemigo.*
import nivel.*

object pantallaPrincipal {
	
	var property nivel = primerNivel
	var property pantalla = nivel.fondo()
	
	method iniciarNivel(){
		
			if(!nivel.esUltimoNivel()){
				nivel.iniciarNivel()	
			}
	}
	
	method iniciar() {
		
			self.configurarPantalla() 
			 
			self.iniciarNivel()	    	
	    	
			game.start()
		
	}

	
	method victoria(){
		game.removeTickEvent("Regenerar energia")
		game.removeTickEvent("Regenerar ataque enemigo")
		//game.removeTickEvent("movimiento ataque enemigo")
		self.agregarCosas(pantallaVictoria) 
	}
		
	method siguienteNivel(siguienteNivel){
		nivel=siguienteNivel
		nivel.iniciarNivel()
	}
	
	
	method configurarPantalla(){
		game.width(34)
		game.height(18)
		game.title("Warrior's Fights")
		game.boardGround(pantalla)
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
	
	var property alto=game.height()
	var property ancho=game.width()

}

class Pantalla{
	var property image
	var property position=game.at(4,4) //ponerlo en el centro
}

const pantallaVictoria = new Pantalla(image="you-win.png")
const pantallaDerrota= new Pantalla(image="game_over.png")

