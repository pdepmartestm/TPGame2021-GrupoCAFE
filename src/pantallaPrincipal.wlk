import wollok.game.*
import personaje.*
import arma.*
import enemigo.*
import nivel.*

object pantallaPrincipal {
	
	var property nivel = primerNivel
	var property pantalla = nivel.fondo()
		
	method siguienteNivel(siguienteNivel){
		nivel=siguienteNivel
		if(nivel==null){
			game.addVisual(pantallaVictoria)
		}
	}
	
	method iniciar() {
		self.configurarPantalla()
		self.agregarPersonajes()
		
		keyboard.x().onPressDo{
			const colliders = game.colliders(nivel.personajePrincipal())
			nivel.personajePrincipal().usarArma()
			//if (colliders.isEmpty()) {
				
				//}
			colliders.forEach{cosa=>
				if(cosa==nivel.enemigo()){
					nivel.personajePrincipal().atacar(nivel.enemigo())
				}
				
			}
		}
    	
    	game.onTick(3000, "Regenerar energia", {nivel.personajePrincipal().regenerarEnergia()})
    	
    	
		game.start()
	}
	
	method configurarPantalla(){
		game.width(15)
		game.height(12)
		game.title("Warrior's Fights")
		game.boardGround(pantalla)
	}
	
	method agregarPersonajes(){
		game.addVisualCharacter(nivel.personajePrincipal())
		game.addVisual(nivel.enemigo())
		game.onTick(2000, "movimiento", { nivel.enemigo().moverseRandom() })
		
	}
	
	method perder(){
		game.addVisual(pantallaDerrota)
	}
	
	method removerCosas(algo){
		game.removeVisual(algo)
	}
	
	method emitirMensaje(contenido, quien){
		game.say(quien, contenido)
	}
	
	
}

class Pantalla{
	var property image
	var property position=game.at(4,4) //ponerlo en el centro
}

const pantallaVictoria = new Pantalla(image="you-win.png")
const pantallaDerrota= new Pantalla(image="game_over.png")

