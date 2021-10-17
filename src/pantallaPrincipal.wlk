import wollok.game.*
import personaje.*
import arma.*
import enemigo.*

object pantallaPrincipal {
	
	method iniciar() {
		self.configurarPantalla()
		self.agregarPersonajes()
		self.agregarMovimientoAPersonaje(guerrero)
		
		keyboard.a().onPressDo({guerrero.ataca(1) })
    	keyboard.d().onPressDo({guerrero.ataca(2) })
    	
    	game.onTick(3000, "Ataca enano hechicero", {enanoHechicero.atacar()})
    
		game.start()
	}
	
	method configurarPantalla(){
		game.height(18) //altura 18
		game.width(35) //ancho 35
		game.title("Warrior's Fights")
		game.boardGround("escenarioArena.png")
	}
	
	method agregarPersonajes(){
		game.addVisual(guerrero)
		game.addVisual(enanoHechicero)
		
	}
	
	method agregarMovimientoAPersonaje(alguien){
		keyboard.left().onPressDo({alguien.moverseHaciaLaIzquierda()})
		keyboard.right().onPressDo({alguien.moverseHaciaLaDerecha()})
		keyboard.up().onPressDo({alguien.moverseHaciaArriba()})
		keyboard.down().onPressDo({alguien.moverseHaciaAbajo()})
	}
	
	
}


