import wollok.game.*
import personaje.*
import enemigo.*

class Arma{
	
	method desaparece(){
		return game.removeVisual(self)	
	}
}

object espada inherits Arma {
	var property position = guerrero.position()
	var direccion = 1
	
	method image(){
		if(direccion == 1)
		return "espada.png"
		else
		return "espada2.png"
	}
	
	method hacia(unaDireccion){
		direccion = unaDireccion
		if(direccion == 2){
			position = position.left(3)
			position = position.up(2)
		}else{
			position = position.right(3)
			position = position.up(2)
		}
	}
	
}

object rayoParalizador inherits Arma{
	var property position = enanoHechicero.position()
	
	method image() = "rayo.png"
	
	method lado(){
		position = position.left(3)
	}	
		

}
