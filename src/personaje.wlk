import wollok.game.*
import arma.*
import pantallaPrincipal.*

class Personaje{
	
	var property image = null
	var property vida = 10
	var property position = game.at(3,5)
	var property arma = null
	var property mensaje = null

	
	method atacar(){
		self.usarArma()		
	}
	
	method usarArma(){

		arma.movimiento()
		
	}
	
	method restarVida(cantidad){
		vida -= cantidad
		//game.say(self, self.mensaje() + ' Vida: '+self.vida().toString())
		
	}
	
	method posicionarArma(){
		self.arma().position(self.position()) //que la posicion inicial de las armas sea la misma que el duenio
		game.addVisual(self.arma())
	}
	
	
}



