import wollok.game.*
import arma.*

class Personaje{
	
	method moverseHaciaLaDerecha()
	method moverseHaciaLaIzquierda()
	method moverseHaciaArriba()
	method moverseHaciaAbajo()
	method ataca(direccion)

	
}

object guerrero inherits Personaje{
	
	var property position = game.at(3,5)
	var property vida = 100
	var property fuerza = 50

	method image() {
		return "guerrero2.png"
	}
	
	override method moverseHaciaLaDerecha(){
		if(recorrido.superaA(32, position.x())){
			position = position.right(1)
		}
	}
	override method moverseHaciaLaIzquierda(){
		if(!recorrido.superaA(1, position.x())){
			position = position.left(1)
		}
		
	}
	override method moverseHaciaArriba(){
		if(recorrido.superaA(12, position.y())){
			position = position.up(1)
		}
	}
	override method moverseHaciaAbajo(){
		if(!recorrido.superaA(1, position.y())){
			position = position.down(1)
		}
		
	}
	
	override method ataca(direccion){
		espada.position(self.position())
		game.addVisual(espada)
		espada.hacia(direccion)
		game.schedule(200, {espada.desaparece()})
	}
}

object recorrido{
	method superaA(limite, posicion){
		return posicion < limite
	}
}
