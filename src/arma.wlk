import wollok.game.*
import personaje.*
import enemigo.*
import protagonista.*
import pantallaPrincipal.*
import areaImagen.*

class Arma{
	
	var property image=null
	var property position=null
	var property poderLetalidad=null 
	const property energiaRequerida=null
	const property miArea = null
	
	method movimiento(){}
	
	method recibeAtaque(armaPersonaje){}
	
	method desaparece(){
		return game.removeVisual(self)	
	}
	
	method position(x,y){
		position=game.at(x,y)
	}
	
	method estoyDentroDelRango(unPersonaje){
		
		const coinciden = true
		const anchoPersonaje = unPersonaje.miArea().ancho()
		const altoPersonaje = unPersonaje.miArea().alto()
		const anchoArma = self.miArea().ancho()
		const altoArma = self.miArea().alto()
	
		if(unPersonaje.position().x() > (self.position().x() + anchoArma)) return !coinciden 
		if(self.position().x() > (unPersonaje.position().x() + anchoPersonaje)) return !coinciden 
		if(unPersonaje.position().y() > (self.position().y() + altoArma)) return !coinciden 
		if(self.position().y() > (unPersonaje.position().y() + altoPersonaje)) return !coinciden 
		
		return coinciden
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
const espada = new Espada(image="espada.png", poderLetalidad=5, energiaRequerida=10, position=game.at(5,7), miArea = new AreaImagen(ancho = 2, alto = 2))
const rayo = new Rayo(image="rayo.png", poderLetalidad=5, miArea = new AreaImagen(ancho = 2, alto = 3))
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