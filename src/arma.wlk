import wollok.game.*
import personaje.*
import enemigo.*
import protagonista.*

class Arma{
	
	var property image=null
	var property position=game.at(27, 8)
	var property poderLetalidad=null 
	const property energiaRequerida=null
	
	method movimiento(){
		
	}
	
	method desaparece(){
		return game.removeVisual(self)	
	}
	
	method position(x,y){
		position=game.at(x,y)
	}
	
	method volverPosicionInicial(){
		position=game.at(30, 8)
	
	}
	
	//si el arma colisiona resta vida, se usa en oncollidedo de nivel
	method colisiona(personaje){
		personaje.restarVida(self.poderLetalidad())
	}
}

class Espada inherits Arma{
	override method movimiento(){
		
		position = position.left(3)
		position = position.up(2)
		
	}
}

class Rayo inherits Arma{
	override method movimiento(){
		
		position = position.left(1)
	}
}
const espada = new Espada(image="espada.png", poderLetalidad=5, energiaRequerida=10, position=game.at(5,7))
const rayo = new Rayo(image="rayo.png", poderLetalidad=5)


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