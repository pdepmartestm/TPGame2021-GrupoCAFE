import wollok.game.*
import personaje.*
import enemigo.*
import protagonista.*

class Arma{
	
	var property image=null
	var property position=null
	var property poderLetalidad=null 
	const property energiaRequerida=null

	
	method movimiento(){
		
	}
	
	method recibeAtaqueDePersonaje(armaPersonaje){}
	method recibeAtaqueEnemigo(armaEnemigo){
	}
	method desaparece(){
		return game.removeVisual(self)	
	}
	
	method position(x,y){
		position=game.at(x,y)
	}
	
	
	//si el arma colisiona resta vida, se usa en oncollidedo de nivel
	method colisiona(personaje){
		personaje.restarVida(self.poderLetalidad())
	}
}

class Espada inherits Arma{
	override method movimiento(){
		
		//position = position.left(3)
		//position = position.up(2)
		
	}
}

class Rayo inherits Arma{
	override method movimiento(){
		
		position = position.left(1)
	}
}
const espada = new Espada(image="espada.png", poderLetalidad=5, energiaRequerida=10)
const espada2 = new Espada(image="espada.png", poderLetalidad=5, energiaRequerida=10)

const rayo = new Rayo(image="rayo.png", poderLetalidad=5)
const rayo2 = new Rayo(image="rayo.png", poderLetalidad=5)

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