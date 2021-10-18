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
	
	method victoria(){
		game.removeTickEvent("Regenerar energia")
		game.removeTickEvent("Regenerar ataque enemigo")
		self.agregarCosas(pantallaVictoria) 
	}
		
	method siguienteNivel(siguienteNivel){
		nivel=siguienteNivel
		nivel.iniciarNivel()
	}
	
	method iniciar() {
		self.configurarPantalla()
		//self.agregarPersonajes()
		self.iniciarNivel()
		
		//Personaje ataca al enemigo con la x
		keyboard.x().onPressDo{
			const colliders = game.colliders(nivel.personajePrincipal())
			nivel.personajePrincipal().usarArma()
			colliders.forEach{cosa=>
				if(cosa==nivel.enemigo()){
					nivel.personajePrincipal().atacar(nivel.enemigo())
				}
				
			}
		}
		
		//Arma del enemigo ataca al personaje principal
		game.onCollideDo(nivel.enemigo().arma(),{personaje=>
			if(personaje==nivel.personajePrincipal()){
				nivel.enemigo().atacar(nivel.personajePrincipal())
		}})
    	
    	//Regenerar energia cada 3 segundos, podriamos hacer que la regenere agarrando objetos del mapa
    	game.onTick(3000, "Regenerar energia", {nivel.personajePrincipal().regenerarEnergia()})
    	
    	//Cuando el ataque se va del mapa, generar uno nuevo
    	game.onTick(1000, "Regenerar ataque enemigo", {
    		if(nivel.enemigo().arma().position().x()<0){
    			nivel.enemigo().arma().volverPosicionInicial() 
    		}
    	})
    	
    	
		game.onTick(500, "movimiento ataque enemigo", { nivel.enemigo().arma().movimiento() })
    	
		game.start()
	}
	
	method configurarPantalla(){
		game.width(34)
		game.height(18)
		game.title("Warrior's Fights")
		game.boardGround(pantalla)
	}
	
	method agregarPersonajes(){
		keyboard.left().onPressDo({nivel.personajePrincipal().moverseHaciaLaIzquierda()})
		keyboard.right().onPressDo({nivel.personajePrincipal().moverseHaciaLaDerecha()})
		keyboard.up().onPressDo({nivel.personajePrincipal().moverseHaciaArriba()})
		keyboard.down().onPressDo({nivel.personajePrincipal().moverseHaciaAbajo()})
		
		game.addVisual(nivel.personajePrincipal())
		game.addVisual(nivel.enemigo())
		nivel.personajePrincipal().posicionarArma()
		nivel.enemigo().posicionarArma()
		game.onTick(500, "movimiento ataque enemigo", { nivel.enemigo().arma().movimiento() })
		
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

