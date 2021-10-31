import wollok.game.*
import arma.*
import pantallaPrincipal.*
import areaImagen.*

class Personaje{
	
	var property image = null
	var property vida = 10
	var property position = game.at(3,5)
	var property arma = null
	var property mensaje = null
	var property miArea = null

	
	method atacar(){
		self.usarArma()		
	}
	
	method usarArma(){
		arma.movimiento()
	}
	
	method restarVida(cantidad){
		vida -= cantidad
	}
	
	method recibeAtaque(enemigo){
		if(enemigo.arma().estoyDentroDelRango(self)){
			self.restarVida(enemigo.arma().poderLetalidad())
			enemigo.posicionarArma()
			pantallaPrincipal.emitirMensaje(self.mensaje(), self)
		}
		
	}
	
	method agregarArma(){
		game.addVisual(self.arma())
	}
	
	method posicionarArma(){}
	
	
}



