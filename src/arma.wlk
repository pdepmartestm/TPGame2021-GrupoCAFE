import wollok.game.*
import personaje.*
import enemigo.*

class Arma{
	
	var property image=null
	var property position=null
	var property poderLetalidad=null
	const property energiaRequerida=null
	
	method puedeLanzarAtaque(personaje){
		if(personaje.energia() >= energiaRequerida){
			self.movimiento()
			return true
		}else{
			return false
		}
		
	}
	
	method movimiento(){}
	
	method desaparece(){
		return game.removeVisual(self)	
	}
}

const espada = new Arma(image="espada.png", poderLetalidad=5, energiaRequerida=10)

/* 
object espada inherits Arma {
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
	
	method image() = "rayo.png"
	
	method lado(){
		position = position.left(3)
	}	
		

}
*/