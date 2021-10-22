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
	
	method recibeAtaqueEnemigo(armaEnemigo){
		self.restarVida(armaEnemigo.poderLetalidad())
		pantallaPrincipal.emitirMensaje("Arghh debo tener mas cuidado",self)
	}
	
	method posicionarArma(){
		self.arma().position(position.x()+2, position.y()+1) //que la posicion inicial de las armas sea la misma que el duenio
		game.addVisual(self.arma())
	}
	
	
}



